import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../models/event.dart';

/// Handles bookings and booking history.
// PUBLIC_INTERFACE
class BookingService extends ChangeNotifier {
  final List<Booking> _bookings = [];

  List<Booking> get bookings => _bookings;

  // PUBLIC_INTERFACE
  void addBooking(Event event, List<String> seats, double totalPrice) {
    final booking = Booking(
      event: event,
      seats: List.of(seats),
      datetime: DateTime.now(),
      totalPrice: totalPrice,
      bookingId: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    _bookings.add(booking);
    notifyListeners();
  }
}
