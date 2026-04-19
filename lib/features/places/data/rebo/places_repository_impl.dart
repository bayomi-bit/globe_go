import 'package:graduation/core/network/api_result.dart';
import 'package:graduation/features/places/data/models/hotel_model.dart';
import 'package:graduation/features/places/data/models/place_model.dart';
import 'package:graduation/features/places/data/rebo/places_repository.dart';

import '../../../../core/network/api_constant.dart';
import '../../../../core/network/api_consumer.dart';

class PlacesRepositoryImpl extends PlacesRepository {
  ApiConsumer apiConsumer;
  PlacesRepositoryImpl({required this.apiConsumer});
  @override
  Future<ApiResult<List<PlaceModel>>> getPlaces(String city)async {
    try{
      var response = await apiConsumer.get(ApiConstants.placeApi+city);
      if (response is List) {
        return ApiResult.success(
          response.map((e) => PlaceModel.fromJson(e)).toList(),
        );
      } else {
        return ApiResult.error('Invalid response format');
      }

    }catch(e){
      return ApiResult.error(e.toString());


    }

  }

  @override
  Future<ApiResult<List<HotelModel>>> getHotels(String city)async {
    try{
      var response = await apiConsumer.get(ApiConstants.hotelsApi+city);
      if (response is List) {
        return ApiResult.success(
          response.map((e) => HotelModel.fromJson(e)).toList(),
        );
      } else {
        return ApiResult.error('Invalid response format');
      }

    }catch(e){
      return ApiResult.error(e.toString());


    }

  }
}