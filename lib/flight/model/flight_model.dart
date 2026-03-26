class FlightModel {
  final String id;
  final String airline;
  final String flightClass;
  final bool isBusinessClass;
  final String from;
  final String fromCity;
  final String to;
  final String toCity;
  final String duration;
  final String departTime;
  final String arriveTime;
  final String date;
  final String price;
  final String airlineLogo;

  const FlightModel({
    required this.id,
    required this.airline,
    required this.flightClass,
    required this.isBusinessClass,
    required this.from,
    required this.fromCity,
    required this.to,
    required this.toCity,
    required this.duration,
    required this.departTime,
    required this.arriveTime,
    required this.date,
    required this.price,
    required this.airlineLogo,
  });
}
