import 'package:clean_archi_travel_app/core/di/dependency_injection.dart';
import 'package:clean_archi_travel_app/feature/trip/domain/entities/trip_entity.dart';
import 'package:clean_archi_travel_app/feature/trip/domain/usecases/add_trip.dart';
import 'package:clean_archi_travel_app/feature/trip/domain/usecases/delete_trip.dart';
import 'package:clean_archi_travel_app/feature/trip/domain/usecases/get_trips.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final tripListNotifierProvider =
    StateNotifierProvider<TripListNotifier, List<TripEntity>>((ref) {
  return TripListNotifier(sl<GetTripsUseCase>(), sl<AddTripUseCase>(), sl<DeleteTripUseCase>())
    ..loadTrips(); // Load trips on init
});

class TripListNotifier extends StateNotifier<List<TripEntity>> {
  final GetTripsUseCase _getTrips;
  final AddTripUseCase _addTrip;
  final DeleteTripUseCase _deleteTrip;

  TripListNotifier(this._getTrips, this._addTrip, this._deleteTrip) : super([]);

  // Load trips from the repository and update the state.
  Future<void> loadTrips() async {
    print('im in loafing trip');
    final tripsOrFailure = await _getTrips();
    tripsOrFailure.fold(
      (error) {
        print("Error loading trips: $error");
        state = [];
      },
      (trips) {
        state = trips;
      },
    );
  }

  Future<void> addNewTrip(TripEntity trip) async {
    print("im in add new trip in riverpod");
    await _addTrip.call(trip: trip);
    loadTrips(); // Reload trips after adding
  }

  Future<void> removeTrip(int tripId) async {
    print("im in delete trip insid the riverpod");
    await _deleteTrip.call(index: tripId);
    loadTrips();
  }
}
