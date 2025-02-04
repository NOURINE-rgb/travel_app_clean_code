// images location description title date
class TripEntity {
  final String title;
  final String description;
  final List<String> images;
  final DateTime date;
  final String location;

  TripEntity(
      {required this.title,
      required this.description,
      required this.images,
      required this.date,
      required this.location});
}
