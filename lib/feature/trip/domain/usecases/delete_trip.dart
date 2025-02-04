import 'package:clean_archi_travel_app/feature/trip/domain/repository/trip_repository.dart';

class DeleteTripUseCase {
  final TripRepository tripRepository;
  const DeleteTripUseCase(this.tripRepository);
  Future<void> call({required int index}) {
    return  tripRepository.deleteTrip(index : index);
  }
}
