part of 'booking_cubit.dart';

enum BookingStatus { initial, loading, booked, error }
enum BookingTab { upcoming, past }

class BookingState {
  final List<FlightModel> bookings;
  final BookingStatus status;
  final BookingTab activeTab;
  final String? error;

  const BookingState({
    this.bookings = const [],
    this.status = BookingStatus.initial,
    this.activeTab = BookingTab.upcoming,
    this.error,
  });

  List<FlightModel> get upcomingBookings => bookings;
  List<FlightModel> get pastBookings => const [];

  bool isBooked(String flightId) =>
      bookings.any((b) => b.id == flightId);

  BookingState copyWith({
    List<FlightModel>? bookings,
    BookingStatus? status,
    BookingTab? activeTab,
    String? error,
  }) {
    return BookingState(
      bookings: bookings ?? this.bookings,
      status: status ?? this.status,
      activeTab: activeTab ?? this.activeTab,
      error: error ?? this.error,
    );
  }
}
