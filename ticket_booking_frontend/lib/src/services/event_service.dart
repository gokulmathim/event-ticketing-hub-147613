import 'package:flutter/material.dart';
import '../models/event.dart';

/// Handles event data and event list state.
// PUBLIC_INTERFACE
class EventService extends ChangeNotifier {
  List<Event> _events = [];

  List<Event> get events => _events;

  // PUBLIC_INTERFACE
  Future<void> fetchEvents() async {
    // TODO: Replace with API call.
    await Future.delayed(const Duration(seconds: 1));
    _events = [
      Event(
        id: '1',
        name: 'Live Concert',
        date: DateTime.now().add(const Duration(days: 10)),
        venue: 'Music Hall',
        description: 'Top performers live!',
        imageUrl: null,
      ),
      Event(
        id: '2',
        name: 'Football Match',
        date: DateTime.now().add(const Duration(days: 5)),
        venue: 'Stadium',
        description: 'Exciting league final.',
        imageUrl: null,
      ),
    ];
    notifyListeners();
  }

  Event? getById(String id) {
    try {
      return _events.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }
}
