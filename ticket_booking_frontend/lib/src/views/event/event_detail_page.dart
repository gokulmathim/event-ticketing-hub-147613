import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/event.dart';
import '../../services/event_service.dart';
import '../../services/booking_service.dart';
import '../../services/payment_service.dart';

class EventDetailPage extends StatefulWidget {
  final String eventId;

  const EventDetailPage({super.key, required this.eventId});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  List<String> selectedSeats = [];
  bool processing = false;

  void _bookTickets(Event event) async {
    setState(() => processing = true);
    // Fake seat prices
    double pricePerSeat = 49.99;
    double total = pricePerSeat * selectedSeats.length;

    PaymentService paymentService = Provider.of<PaymentService>(context, listen: false);
    bool paid = await paymentService.payWithStripe(
      amount: total,
      currency: 'USD',
      description: 'Tickets for ${event.name}',
    );
    if (paid) {
      Provider.of<BookingService>(context, listen: false)
          .addBooking(event, selectedSeats, total);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Booking successful!')));
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Payment failed')));
      }
    }
    setState(() => processing = false);
  }

  @override
  Widget build(BuildContext context) {
    EventService eventSrv = Provider.of<EventService>(context, listen: false);
    Event? event = eventSrv.getById(widget.eventId);
    if (event == null) return const Scaffold(body: Center(child: Text('Event not found')));

    return Scaffold(
      appBar: AppBar(title: Text(event.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(event.venue, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(event.date.toLocal().toString(), style: const TextStyle(color: Colors.black54)),
            const Divider(height: 32),
            Text(event.description),
            const SizedBox(height: 18),
            const Text("Select your seats:"),
            SeatSelectionWidget(
              seatCount: 30,
              selected: selectedSeats,
              onChanged: (seats) => setState(() => selectedSeats = List.of(seats)),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: processing || selectedSeats.isEmpty
                  ? null
                  : () => _bookTickets(event),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
              ),
              child:
                  processing ? const CircularProgressIndicator() : const Text('Book & Pay'),
            ),
          ],
        ),
      ),
    );
  }
}

class SeatSelectionWidget extends StatefulWidget {
  final int seatCount;
  final List<String> selected;
  final ValueChanged<List<String>> onChanged;
  const SeatSelectionWidget(
      {super.key,
      required this.seatCount,
      required this.selected,
      required this.onChanged});

  @override
  State<SeatSelectionWidget> createState() => _SeatSelectionWidgetState();
}

class _SeatSelectionWidgetState extends State<SeatSelectionWidget> {
  late List<String> selectedSeats;

  @override
  void initState() {
    super.initState();
    selectedSeats = List.of(widget.selected);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 8,
      children: List.generate(widget.seatCount, (idx) {
        String seatNum = (idx + 1).toString();
        bool selected = selectedSeats.contains(seatNum);
        return FilterChip(
          label: Text(seatNum),
          selected: selected,
          onSelected: (v) {
            setState(() {
              if (selected) {
                selectedSeats.remove(seatNum);
              } else {
                selectedSeats.add(seatNum);
              }
              widget.onChanged(selectedSeats);
            });
          },
          selectedColor: Theme.of(context).colorScheme.secondary,
          showCheckmark: true,
        );
      }),
    );
  }
}
