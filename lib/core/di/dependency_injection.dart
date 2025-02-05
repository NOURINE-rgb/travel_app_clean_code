import "package:clean_archi_travel_app/feature/trip/data/datasource/trip_local_data_source.dart";
import "package:clean_archi_travel_app/feature/trip/data/models/trip_model.dart";
import "package:clean_archi_travel_app/feature/trip/data/repository/trip_repository_impl.dart";
import "package:clean_archi_travel_app/feature/trip/domain/repository/trip_repository.dart";
import "package:clean_archi_travel_app/feature/trip/domain/usecases/add_trip.dart";
import "package:clean_archi_travel_app/feature/trip/domain/usecases/delete_trip.dart";
import "package:clean_archi_travel_app/feature/trip/domain/usecases/get_trips.dart";
import "package:get_it/get_it.dart";
import "package:hive_flutter/hive_flutter.dart";

final sl = GetIt.instance;
void setupLocator() {
  // rtegistre hiveBox
  sl.registerLazySingleton<Box<TripModel>>(
    () => Hive.box<TripModel>("trips"),
  );
   // register dependencies
  sl.registerLazySingleton<TripLocalDataSource>(
    () => TripLocalDataSourceImpl(
      sl<Box<TripModel>>(),
    ),
  );
  sl.registerLazySingleton<TripRepository>(
    () => TripRepositoryImpl(
      sl<TripLocalDataSource>(),
    ),
  );
   sl.registerLazySingleton(() => AddTripUseCase(sl<TripRepository>()));
  sl.registerLazySingleton(() => DeleteTripUseCase(sl<TripRepository>()));
  sl.registerLazySingleton(() => GetTripsUseCase(sl<TripRepository>()));

}
