import 'package:hive_flutter/hive_flutter.dart';
import 'package:skiee/data/models/api_flight_model.dart';

/// Wraps the Hive box used to cache [ApiFlightModel] objects offline.
class FlightsLocalStorage {
  static const String _boxName = 'flights_cache';

  /// Opens (or re-opens) the Hive box. Call once during app init.
  static Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox<ApiFlightModel>(_boxName);
    }
  }

  Box<ApiFlightModel> get _box => Hive.box<ApiFlightModel>(_boxName);

  /// Replaces all cached flights for the given cache key.
  Future<void> saveFlights(String cacheKey, List<ApiFlightModel> flights) async {
    await _box.clear();
    final map = {for (int i = 0; i < flights.length; i++) '${cacheKey}_$i': flights[i]};
    await _box.putAll(map);
  }

  /// Returns all cached flights; empty list if nothing is stored.
  List<ApiFlightModel> getFlights() => _box.values.toList();

  /// Whether any flights are currently cached.
  bool get hasCache => _box.isNotEmpty;

  /// Clears all cached data.
  Future<void> clear() => _box.clear();
}
