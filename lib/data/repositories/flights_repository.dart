import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:skiee/data/local/flights_local_storage.dart';
import 'package:skiee/data/models/api_flight_model.dart';
import 'package:skiee/data/services/flights_api_service.dart';
import 'package:skiee/domain/repositories/i_flights_repository.dart';

/// Concrete repository that:
/// 1. Checks for connectivity before calling the API.
/// 2. Caches results in Hive for offline access.
/// 3. Falls back to Hive cache when offline or on transient API errors.
class FlightsRepository implements IFlightsRepository {
  FlightsRepository({
    FlightsApiService? apiService,
    FlightsLocalStorage? localStorage,
  })  : _api = apiService ?? FlightsApiService(),
        _local = localStorage ?? FlightsLocalStorage();

  final FlightsApiService _api;
  final FlightsLocalStorage _local;

  @override
  Future<List<ApiFlightModel>> getFlights({
    required String departure,
    required String arrival,
    required String date,
  }) async {
    final connectivity = await Connectivity().checkConnectivity();
    final isOnline = connectivity.any((r) => r != ConnectivityResult.none);

    // Build a deterministic cache key for this query
    final cacheKey = '${departure}_${arrival}_$date';

    if (isOnline) {
      try {
        final flights = await _api.fetchFlights(
          departure: departure,
          arrival: arrival,
          date: date,
        );
        // Persist to Hive so the next offline session can load results
        await _local.saveFlights(cacheKey, flights);
        return flights;
      } catch (_) {
        // API failed — fall back to local cache rather than surfacing an error
        // (if cache is empty the _loadFromCache call will throw OfflineException)
      }
    }

    return _loadFromCache();
  }

  List<ApiFlightModel> _loadFromCache() {
    if (_local.hasCache) return _local.getFlights();
    throw OfflineException(
      'You\'re offline and no cached flights are available. '
      'Please connect to the internet and search again.',
    );
  }
}

/// Thrown when the device is offline and no local cache exists.
class OfflineException implements Exception {
  const OfflineException(this.message);
  final String message;

  @override
  String toString() => 'OfflineException: $message';
}
