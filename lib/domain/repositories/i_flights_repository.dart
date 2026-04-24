import 'package:skiee/data/models/api_flight_model.dart';

/// Abstract contract for the flights repository.
/// Both the concrete [FlightsRepository] and any test fakes implement this.
abstract class IFlightsRepository {
  /// Returns a list of flights for the given route and date.
  /// May return cached data when the device is offline.
  Future<List<ApiFlightModel>> getFlights({
    required String departure,
    required String arrival,
    required String date,
  });
}
