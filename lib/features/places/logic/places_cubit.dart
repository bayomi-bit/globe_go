import 'package:bloc/bloc.dart';
import 'package:graduation/features/places/data/rebo/places_repository.dart';
import 'package:meta/meta.dart';

import '../data/models/hotel_model.dart';
import '../data/models/place_model.dart';

part 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  PlacesRepository placesRepository;

  PlacesCubit(this.placesRepository) : super(PlacesInitial());


  Future<void> getPlaces(String city) async {
    emit(PlacesLoading());

      final result = await placesRepository.getPlaces(city);
      if (result.isSuccess) {
        emit(PlacesLoaded(result.data!));
      } else {
        emit(PlacesError(result.error!));
      }

  }
}
