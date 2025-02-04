// get add delete trip
import 'package:clean_archi_travel_app/core/error/failures.dart';
import 'package:clean_archi_travel_app/feature/trip/domain/entities/trip_entity.dart';
import 'package:dartz/dartz.dart';

abstract class TripRepository {
  Future< Either<Failures,List<TripEntity>>> getTrips();
  Future<void> addTrip({required TripEntity trip});
  Future<void> deleteTrip({required int index});
}
