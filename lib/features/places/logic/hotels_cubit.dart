import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/hotel_model.dart';
import '../data/rebo/places_repository.dart';

part 'hotels_state.dart';

class HotelsCubit extends Cubit<HotelsState> {
  PlacesRepository placesRepository;
  HotelsCubit( this.placesRepository) : super(HotelsInitial());
  Future<void> getHotels(String city) async {
    emit(HotelsLoading());
    final result = await placesRepository.getHotels(city);
    if (result.isSuccess) {
      emit(HotelsLoaded(result.data!));
    } else {
      emit(HotelsError(result.error!));
    }

  }

}
