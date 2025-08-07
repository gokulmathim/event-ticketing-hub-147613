import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/booking_service.dart';
import '../../models/booking.dart';

class BookingHistoryPage extends StatelessWidget {
  const BookingHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookings = Provider.of<BookingService>(context).bookings;

    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings')),
      body: bookings.isEmpty
          ? const Center(child: Text('No bookings yet.'))
          : ListView.separated(
              itemCount: bookings.length,
              separatorBuilder: (c, i) => const Divider(),
              itemBuilder: (ctx, idx) {
                Booking b = bookings[idx];
                return ListTile(
                  leading: Icon(Icons.event_seat, color: Theme.of(context).colorScheme.primary),
                  title: Text('${b.event.name} • ${b.event.venue}'),
                  subtitle: Text(
                      '${b.seats.length} seat(s) • Booked on ${b.datetime.toLocal().toString().substring(0, 16)}'
                  ),
                  trailing: Text('\$${b.totalPrice.toStringAsFixed(2)}'),
                );
              },
            ),
    );
  }
}
