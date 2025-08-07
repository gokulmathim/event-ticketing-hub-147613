import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/event.dart';
import '../../services/event_service.dart';
import 'event_detail_page.dart';

class EventListPage extends StatefulWidget {
  const EventListPage({super.key});

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<EventService>(context, listen: false).fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    var eventService = Provider.of<EventService>(context);
    List<Event> events = eventService.events;

    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: events.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: events.length,
              separatorBuilder: (c, i) => const Divider(),
              itemBuilder: (ctx, idx) {
                final event = events[idx];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: const Icon(Icons.event_seat, color: Colors.white),
                  ),
                  title: Text(event.name),
                  subtitle: Text(
                    '${event.venue}\n${event.date.toLocal().toString().substring(0, 16)}',
                    maxLines: 2,
                  ),
                  isThreeLine: true,
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => EventDetailPage(eventId: event.id),
                    ));
                  },
                );
              },
            ),
    );
  }
}
