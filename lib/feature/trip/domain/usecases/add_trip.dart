import 'package:clean_archi_travel_app/feature/trip/domain/entities/trip_entity.dart';
import 'package:clean_archi_travel_app/feature/trip/domain/repository/trip_repository.dart';

class AddTripUseCase {
  final TripRepository tripRepository;
  const AddTripUseCase(this.tripRepository);
  Future<void> call({required TripEntity trip}) {
    return  tripRepository.addTrip(trip: trip);
  }
}
