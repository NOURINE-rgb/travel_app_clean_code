import 'package:clean_archi_travel_app/core/error/failures.dart';
import 'package:clean_archi_travel_app/feature/trip/domain/entities/trip_entity.dart';
import 'package:clean_archi_travel_app/feature/trip/domain/repository/trip_repository.dart';
import 'package:dartz/dartz.dart';
class GetTripsUseCase {
  final TripRepository tripRepository;
  GetTripsUseCase(this.tripRepository);
  Future<Either<Failures,List<TripEntity>>> call() async {
    return tripRepository.getTrips();
  }
}
