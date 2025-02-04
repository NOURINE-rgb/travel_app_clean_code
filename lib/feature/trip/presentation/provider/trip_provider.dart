import 'package:clean_archi_travel_app/feature/trip/data/datasource/trip_local_data_source.dart';
import 'package:clean_archi_travel_app/feature/trip/data/models/trip_model.dart';
import 'package:clean_archi_travel_app/feature/trip/data/repository/trip_repository_impl.dart';
import 'package:clean_archi_travel_app/feature/trip/domain/entities/trip_entity.dart';
import 'package:clean_archi_travel_app/feature/trip/domain/repository/trip_repository.dart';
import 'package:clean_archi_travel_app/feature/trip/domain/usecases/add_trip.dart';
import 'package:clean_archi_travel_app/feature/trip/domain/usecases/delete_trip.dart';
import 'package:clean_archi_travel_app/feature/trip/domain/usecases/get_trips.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Local data source provider
final tripLocalDataSourceProvider = Provider<TripLocalDataSource>((ref) {
  final Box<TripModel> tripBox =
      Hive.box('trips'); // Ensure this is registered properly
  return TripLocalDataSourceImpl(tripBox);
});

// Repository provider
final tripRepositoryProvider = Provider<TripRepository>((ref) {
  final localDataSource = ref.read(tripLocalDataSourceProvider);
  return TripRepositoryImpl(localDataSource);
});

// UseCase providers
final getTripsProvider = Provider<GetTripsUseCase>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return GetTripsUseCase(repository);
});

final addTripProvider = Provider<AddTripUseCase>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return AddTripUseCase(repository);
});

final deleteTripProvider = Provider<DeleteTripUseCase>((ref) {
  final repository = ref.read(tripRepositoryProvider);
  return DeleteTripUseCase(repository);
});

// Notifier provider
final tripListNotifierProvider =
    StateNotifierProvider<TripListNotifier, List<TripEntity>>((ref) {
  final getTrips = ref.read(getTripsProvider);
  final addTrip = ref.read(addTripProvider);
  final deleteTrip = ref.read(deleteTripProvider);

  return TripListNotifier(getTrips, addTrip, deleteTrip)
    ..loadTrips(); // Load trips on init
});

class TripListNotifier extends StateNotifier<List<TripEntity>> {
  final GetTripsUseCase _getTrips;
  final AddTripUseCase _addTrip;
  final DeleteTripUseCase _deleteTrip;

  TripListNotifier(this._getTrips, this._addTrip, this._deleteTrip) : super([]);

  // Load trips from the repository and update the state.
  Future<void> loadTrips() async {
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
    await _addTrip.call(trip: trip);
    loadTrips(); // Reload trips after adding
  }

  Future<void> removeTrip(int tripId) async {
    await _deleteTrip.call(index: tripId);
    loadTrips();
  }
}
