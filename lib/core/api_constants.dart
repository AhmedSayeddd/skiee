/// SerpAPI configuration constants.
/// ⚠️  Replace [serpApiKey] with your real key from https://serpapi.com/manage-api-key
/// ⚠️  Do NOT commit this file to a public repository.
class ApiConstants {
  ApiConstants._();

  static const String serpApiKey = 'https://serpapi.com/search?engine=google_flights'; // ← paste your key here
  static const String baseUrl = 'https://serpapi.com/search';

  /// Default search params used on the home screen
  static const String defaultDeparture = 'CDG';
  static const String defaultArrival = 'LHR';
  static const String defaultDate = '2025-08-01';
}
