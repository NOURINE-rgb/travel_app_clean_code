// images location description title date
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clean_archi_travel_app/feature/trip/domain/entities/trip_entity.dart';
part 'trip_model.g.dart';

@HiveType(typeId: 0)
class TripModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final List<String> images;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final String location;

  TripModel(
      {required this.title,
      required this.description,
      required this.images,
      required this.date,
      required this.location});
  factory TripModel.fromEntity(TripEntity trip) {
    return TripModel(
        title: trip.title,
        description: trip.description,
        images: trip.images,
        date: trip.date,
        location: trip.location);
  }
  TripEntity toEntity() {
    return TripEntity(
        title: title,
        description: description,
        images: images,
        date: date,
        location: location);
  }
}
