import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skiee/data/models/api_flight_model.dart';
import 'package:skiee/data/repositories/flights_repository.dart';
import 'package:skiee/data/services/flights_api_service.dart';
import 'package:skiee/domain/repositories/i_flights_repository.dart';

part 'flights_state.dart';

/// Manages the Google Flights search state (loading, success, error).
/// Lives in the widget tree via [BlocProvider] in main.dart.
class FlightsCubit extends Cubit<FlightsState> {
  FlightsCubit({IFlightsRepository? repository})
      : _repository = repository ?? FlightsRepository(),
        super(const FlightsInitial());

  final IFlightsRepository _repository;

  // ── Public API ─────────────────────────────────────────────────────────

  /// Fetches flights for [departure] → [arrival] on [date].
  /// Switches through Loading → Success|Error states.
  Future<void> fetchFlights({
    required String departure,
    required String arrival,
    required String date,
  }) async {
    emit(const FlightsLoading());
    try {
      final flights = await _repository.getFlights(
        departure: departure,
        arrival: arrival,
        date: date,
      );
      emit(FlightsSuccess(
        allFlights: flights,
        displayFlights: flights,
      ));
    } on OfflineException catch (e) {
      emit(FlightsError(e.message));
    } on FlightsApiException catch (e) {
      emit(FlightsError(e.message));
    } catch (e) {
      emit(FlightsError('Something went wrong. Please try again.'));
    }
  }

  /// Applies a text [query] filter (airline name / airport code) on the
  /// already-loaded flights without triggering another API call.
  void filterFlights(String query) {
    final current = state;
    if (current is! FlightsSuccess) return;

    final q = query.toLowerCase().trim();
    final filtered = q.isEmpty
        ? current.allFlights
        : current.allFlights.where((f) {
            return f.airline.toLowerCase().contains(q) ||
                f.departureAirport.toLowerCase().contains(q) ||
                f.arrivalAirport.toLowerCase().contains(q) ||
                f.departureCity.toLowerCase().contains(q) ||
                f.arrivalCity.toLowerCase().contains(q);
          }).toList();

    emit(current.copyWith(
      displayFlights: _sort(filtered, current.sortBy),
      filterQuery: query,
    ));
  }

  /// Changes sort order without re-fetching.
  void sortFlights(FlightSortOption option) {
    final current = state;
    if (current is! FlightsSuccess) return;
    emit(current.copyWith(
      displayFlights: _sort(current.displayFlights, option),
      sortBy: option,
    ));
  }

  // ── Helpers ──────────────────────────────────────────────────────────

  List<ApiFlightModel> _sort(List<ApiFlightModel> list, FlightSortOption option) {
    final copy = List<ApiFlightModel>.from(list);
    switch (option) {
      case FlightSortOption.price:
        copy.sort((a, b) => a.price.compareTo(b.price));
      case FlightSortOption.duration:
        copy.sort((a, b) => a.duration.compareTo(b.duration));
      case FlightSortOption.airline:
        copy.sort((a, b) => a.airline.compareTo(b.airline));
    }
    return copy;
  }
}
