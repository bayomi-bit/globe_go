import 'package:bloc/bloc.dart';
import 'package:graduation/features/trips/data/rebo/trips_repository.dart';
import 'package:meta/meta.dart';

import '../data/models/trips_model.dart';

part 'trips_state.dart';

class TripsCubit extends Cubit<TripsState> {
  TripsRepository tripsRepository;

  TripsCubit({required this.tripsRepository}) : super(TripsInitial());

  Future<void> getTrips() async {
    emit(TripsLoading());

      var response = await tripsRepository.getTrips();
      if (response.isSuccess) {
        emit(TripsLoaded(response.data!));
      }else {
        emit(TripsError(response.error!));
      }

  }
}
