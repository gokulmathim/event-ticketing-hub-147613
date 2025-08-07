import 'event.dart';

class Booking {
  final String bookingId;
  final Event event;
  final List<String> seats;
  final DateTime datetime;
  final double totalPrice;

  Booking({
    required this.bookingId,
    required this.event,
    required this.seats,
    required this.datetime,
    required this.totalPrice,
  });
}
