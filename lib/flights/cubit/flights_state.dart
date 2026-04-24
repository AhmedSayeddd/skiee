part of 'flights_cubit.dart';

/// States emitted by [FlightsCubit].
abstract class FlightsState {
  const FlightsState();
}

/// Initial state — no search performed yet.
class FlightsInitial extends FlightsState {
  const FlightsInitial();
}

/// API call / cache load in progress.
class FlightsLoading extends FlightsState {
  const FlightsLoading();
}

/// Flights successfully loaded (with optional client-side filtered list).
class FlightsSuccess extends FlightsState {
  const FlightsSuccess({
    required this.allFlights,
    required this.displayFlights,
    this.sortBy = FlightSortOption.price,
    this.filterQuery = '',
  });

  /// Full list from API/cache (never filtered for reset purposes).
  final List<ApiFlightModel> allFlights;

  /// The list currently shown in the UI (may be filtered/sorted).
  final List<ApiFlightModel> displayFlights;

  final FlightSortOption sortBy;
  final String filterQuery;

  FlightsSuccess copyWith({
    List<ApiFlightModel>? allFlights,
    List<ApiFlightModel>? displayFlights,
    FlightSortOption? sortBy,
    String? filterQuery,
  }) {
    return FlightsSuccess(
      allFlights: allFlights ?? this.allFlights,
      displayFlights: displayFlights ?? this.displayFlights,
      sortBy: sortBy ?? this.sortBy,
      filterQuery: filterQuery ?? this.filterQuery,
    );
  }
}

/// An error occurred during fetch.
class FlightsError extends FlightsState {
  const FlightsError(this.message);
  final String message;
}

/// Sort options available on the success screen.
enum FlightSortOption { price, duration, airline }
