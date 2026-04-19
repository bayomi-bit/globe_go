import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/agency_trips_model.dart';
import '../../data/rebo/trips_repository.dart';

part 'agency_trips_state.dart';

class AgencyTripsCubit extends Cubit<AgencyTripsState> {
  TripsRepository tripsRepository;

  AgencyTripsCubit(this.tripsRepository) : super(AgencyTripsInitial());

  Future<void> getAgencyTrips() async {
    emit(AgencyTripsLoading());

    var response = await tripsRepository.getAgencyTrips();
    if (response.isSuccess) {
      emit(AgencyTripsLoaded(response.data!));
    } else {
      emit(AgencyTripsError(response.error!));
    }


  }
}
