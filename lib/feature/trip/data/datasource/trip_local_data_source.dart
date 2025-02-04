import 'package:clean_archi_travel_app/feature/trip/data/models/trip_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class TripLocalDataSource {
  List<TripModel> getTrips();
  void addTrip({required TripModel trip});
  void deleteTrip({required int index});
}

class TripLocalDataSourceImpl implements TripLocalDataSource {
  final Box<TripModel> tripBox;
  TripLocalDataSourceImpl(this.tripBox);
  @override
  List<TripModel> getTrips() => tripBox.values.toList();

  @override
  void addTrip({required TripModel trip}) {
    tripBox.add(trip);
  }

  @override
  void deleteTrip({required int index}) {
    tripBox.deleteAt(index);
  }
}
