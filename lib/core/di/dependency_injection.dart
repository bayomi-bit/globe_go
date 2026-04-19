import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:graduation/features/trips/data/rebo/trips_repository.dart';

import '../../features/places/data/rebo/places_repository.dart';
import '../../features/places/data/rebo/places_repository_impl.dart';
import '../../features/places/logic/hotels_cubit.dart';
import '../../features/places/logic/places_cubit.dart';
import '../../features/trips/data/rebo/trips_repository_impl.dart';
import '../../features/trips/logic/agency_logic/agency_trips_cubit.dart';
import '../../features/trips/logic/trips_cubit.dart';
import '../network/api_consumer.dart';
import '../network/dio/dio_factory.dart';
import '../network/dio/dio_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  //dio
  Dio dio = DioFactory().dio;
  getIt.registerLazySingleton<ApiConsumer>(() => DioService(dio));

  //Places screen
  getIt.registerFactory<PlacesCubit>(() => PlacesCubit(getIt()));
  getIt.registerLazySingleton<PlacesRepository>(
    () => PlacesRepositoryImpl(apiConsumer: getIt()),
  );
  getIt.registerFactory<HotelsCubit>(() => HotelsCubit(getIt()));
  // trips screen
  getIt.registerFactory<TripsCubit>(() => TripsCubit(tripsRepository: getIt()));
  getIt.registerLazySingleton<TripsRepository>(
    () => TripsRepositoryImpl(apiConsumer: getIt()),
  );
  getIt.registerFactory<AgencyTripsCubit>(() => AgencyTripsCubit(getIt()));
}
