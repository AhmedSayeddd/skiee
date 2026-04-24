import 'package:dio/dio.dart';
import 'package:skiee/core/api_constants.dart';
import 'package:skiee/data/models/api_flight_model.dart';

/// Fetches Google Flights data from SerpAPI.
class FlightsApiService {
  FlightsApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 20),
        headers: {'Accept': 'application/json'},
      ),
    );
  }

  late final Dio _dio;

  /// Fetches flights from SerpAPI.
  ///
  /// [departure] – IATA departure airport code (e.g. "CDG")
  /// [arrival]   – IATA arrival airport code   (e.g. "LHR")
  /// [date]      – travel date in YYYY-MM-DD format
  ///
  /// Throws [FlightsApiException] on any error.
  Future<List<ApiFlightModel>> fetchFlights({
    required String departure,
    required String arrival,
    required String date,
    int type = 2, // 2 = one-way
    int adults = 1,
    int currency = 1, // 1 = USD
  }) async {
    try {
      final response = await _dio.get(
        '',
        queryParameters: {
          'engine': 'google_flights',
          'departure_id': departure,
          'arrival_id': arrival,
          'outbound_date': date,
          'type': type,
          'adults': adults,
          'currency': 'USD',
          'hl': 'en',
          'api_key': ApiConstants.serpApiKey,
        },
      );

      if (response.statusCode != 200) {
        throw FlightsApiException(
          'Unexpected status code: ${response.statusCode}',
        );
      }

      final data = response.data as Map<String, dynamic>;

      // SerpAPI returns results in "best_flights" and "other_flights"
      final List<dynamic> bestFlights =
          (data['best_flights'] as List<dynamic>?) ?? [];
      final List<dynamic> otherFlights =
          (data['other_flights'] as List<dynamic>?) ?? [];

      final allFlights = [...bestFlights, ...otherFlights];

      if (allFlights.isEmpty) {
        return [];
      }

      return allFlights
          .map((f) => ApiFlightModel.fromJson(f as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw FlightsApiException(_dioErrorMessage(e));
    } catch (e) {
      throw FlightsApiException(e.toString());
    }
  }

  String _dioErrorMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out. Check your internet and try again.';
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        if (code == 401) return 'Invalid API key.';
        if (code == 429) return 'Rate limit exceeded. Try again later.';
        return 'Server error ($code). Please try again.';
      case DioExceptionType.unknown:
        return 'No internet connection.';
      default:
        return e.message ?? 'An unexpected error occurred.';
    }
  }
}

/// Typed exception thrown by [FlightsApiService].
class FlightsApiException implements Exception {
  const FlightsApiException(this.message);
  final String message;

  @override
  String toString() => 'FlightsApiException: $message';
}
