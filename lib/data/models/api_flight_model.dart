/// Dart model that mirrors the SerpAPI Google Flights response.
/// Annotated for Hive storage — the adapter lives in api_flight_model.g.dart.
library;

import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class ApiFlightModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String airline;

  @HiveField(2)
  final String flightNumber;

  @HiveField(3)
  final String departureAirport;

  @HiveField(4)
  final String arrivalAirport;

  @HiveField(5)
  final String departureTime; // e.g. "10:10"

  @HiveField(6)
  final String arrivalTime; // e.g. "11:20"

  @HiveField(7)
  final String duration; // e.g. "1h 10m"

  @HiveField(8)
  final int price; // in USD, 0 if unknown

  @HiveField(9)
  final String travelClass; // "Economy", "Business"

  @HiveField(10)
  final String airlineLogo; // URL

  @HiveField(11)
  final String departureCity;

  @HiveField(12)
  final String arrivalCity;

  @HiveField(13)
  final String date; // "2025-08-01"

  ApiFlightModel({
    required this.id,
    required this.airline,
    required this.flightNumber,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.price,
    required this.travelClass,
    required this.airlineLogo,
    required this.departureCity,
    required this.arrivalCity,
    required this.date,
  });

  /// Parses a single top-level flight object from SerpAPI JSON.
  factory ApiFlightModel.fromJson(Map<String, dynamic> json) {
    // SerpAPI nests legs inside a "flights" array
    final legs = (json['flights'] as List<dynamic>?) ?? [];
    final firstLeg =
        legs.isNotEmpty ? legs.first as Map<String, dynamic> : <String, dynamic>{};
    final lastLeg =
        legs.isNotEmpty ? legs.last as Map<String, dynamic> : <String, dynamic>{};

    final depAirport =
        firstLeg['departure_airport'] as Map<String, dynamic>? ?? {};
    final arrAirport =
        lastLeg['arrival_airport'] as Map<String, dynamic>? ?? {};

    final airline = firstLeg['airline'] as String? ?? 'Unknown';
    final flightNumber = firstLeg['flight_number'] as String? ?? '';
    final logo = firstLeg['airline_logo'] as String? ?? '';

    final durationMinutes = json['total_duration'] as int? ?? 0;
    final durationStr = _formatDuration(durationMinutes);

    final rawPrice = json['price'] as int? ?? 0;

    final depTime = depAirport['time'] as String? ?? '';
    final arrTime = arrAirport['time'] as String? ?? '';

    return ApiFlightModel(
      id: '${flightNumber}_${depAirport['id'] ?? ''}_${arrAirport['id'] ?? ''}',
      airline: airline,
      flightNumber: flightNumber,
      departureAirport: depAirport['id'] as String? ?? '',
      arrivalAirport: arrAirport['id'] as String? ?? '',
      departureTime: depTime,
      arrivalTime: arrTime,
      duration: durationStr,
      price: rawPrice,
      travelClass: firstLeg['travel_class'] as String? ?? 'Economy',
      airlineLogo: logo,
      departureCity: depAirport['name'] as String? ?? '',
      arrivalCity: arrAirport['name'] as String? ?? '',
      date: depTime.length >= 10 ? depTime.substring(0, 10) : '',
    );
  }

  /// Formats raw minutes into a human-readable duration string.
  static String _formatDuration(int minutes) {
    if (minutes <= 0) return '';
    final h = minutes ~/ 60;
    final m = minutes % 60;
    if (h == 0) return '${m}m';
    if (m == 0) return '${h}h';
    return '${h}h ${m}m';
  }

  /// Price as a formatted currency string.
  String get priceDisplay => price > 0 ? '\$$price' : 'N/A';

  /// First word of the city name (short label for cards).
  String get departureCityShort => departureCity.split(' ').first;
  String get arrivalCityShort => arrivalCity.split(' ').first;

  @override
  String toString() =>
      'ApiFlightModel($flightNumber: $departureAirport→$arrivalAirport \$$price)';
}
