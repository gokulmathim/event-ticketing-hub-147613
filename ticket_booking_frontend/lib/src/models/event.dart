class Event {
  final String id;
  final String name;
  final DateTime date;
  final String venue;
  final String description;
  final String? imageUrl;

  Event({
    required this.id,
    required this.name,
    required this.date,
    required this.venue,
    required this.description,
    this.imageUrl,
  });
}
