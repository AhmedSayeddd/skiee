import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skiee/flight/model/flight_model.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(const BookingState());

  void selectTab(BookingTab tab) {
    emit(state.copyWith(activeTab: tab));
  }

  Future<void> bookFlight(FlightModel flight) async {
    emit(state.copyWith(status: BookingStatus.loading));
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    final alreadyBooked = state.bookings.any((b) => b.id == flight.id);
    if (alreadyBooked) {
      emit(state.copyWith(status: BookingStatus.error, error: 'Already booked'));
      return;
    }

    final updated = List<FlightModel>.from(state.bookings)..add(flight);
    emit(state.copyWith(bookings: updated, status: BookingStatus.booked, error: null));
  }

  bool isBooked(String flightId) =>
      state.bookings.any((b) => b.id == flightId);
}
