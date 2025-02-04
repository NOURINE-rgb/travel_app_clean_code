// i will impliment it after

import 'package:clean_archi_travel_app/core/error/failures.dart';
import 'package:clean_archi_travel_app/feature/trip/data/datasource/trip_local_data_source.dart';
import 'package:clean_archi_travel_app/feature/trip/data/models/trip_model.dart';
import 'package:clean_archi_travel_app/feature/trip/domain/entities/trip_entity.dart';
import 'package:clean_archi_travel_app/feature/trip/domain/repository/trip_repository.dart';
import 'package:dartz/dartz.dart';

class TripRepositoryImpl implements TripRepository {
  final TripLocalDataSource tripLocalDataSource;
  const TripRepositoryImpl(this.tripLocalDataSource);
  @override
  Future<void> addTrip({required TripEntity trip}) async {
    final tripModel = TripModel.fromEntity(trip);
    tripLocalDataSource.addTrip(trip: tripModel);
  }

  @override
  Future<void> deleteTrip({required int index}) async {
    tripLocalDataSource.deleteTrip(index: index);
  }

  @override
  Future<Either<Failures, List<TripEntity>>> getTrips() async {
    try {
      final List<TripModel> tripList = tripLocalDataSource.getTrips();
      return right(
        tripList
            .map(
              (e) => e.toEntity(),
            )
            .toList(),
      );
    } catch (e) {
      return left(
        SomeError(
          e.toString(),
        ),
      );
    }
  }
}
