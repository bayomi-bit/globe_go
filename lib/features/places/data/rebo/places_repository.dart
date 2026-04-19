import 'package:graduation/core/network/api_result.dart';

import '../models/hotel_model.dart';
import '../models/place_model.dart';

abstract class PlacesRepository {
  Future<ApiResult<List<PlaceModel>>>getPlaces(String city);
  Future<ApiResult<List<HotelModel>>> getHotels(String city);
}


