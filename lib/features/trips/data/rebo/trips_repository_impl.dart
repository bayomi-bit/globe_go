import 'package:graduation/core/network/api_result.dart';
import 'package:graduation/features/trips/data/models/agency_trips_model.dart';
import 'package:graduation/features/trips/data/models/trips_model.dart';
import 'package:graduation/features/trips/data/rebo/trips_repository.dart';

import '../../../../core/network/api_constant.dart';
import '../../../../core/network/api_consumer.dart';

class TripsRepositoryImpl extends TripsRepository {
  ApiConsumer apiConsumer;

  TripsRepositoryImpl({required this.apiConsumer});

  @override
  Future<ApiResult<List<TripsModel>>> getTrips() async {
    try {
      var response = await apiConsumer.get(ApiConstants.tripsApi);
      if (response is List) {
        return ApiResult.success(
          response.map((e) => TripsModel.fromJson(e)).toList(),
        );
      } else {
        return ApiResult.error('Invalid response format');
      }
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  @override
  Future<ApiResult<List<AgencyTrips>>> getAgencyTrips() async {
    try {
      var response = await apiConsumer.get(ApiConstants.agencyTripsApi);
      if (response is List) {
        return ApiResult.success(
          response.map((e) => AgencyTrips.fromJson(e)).toList(),
        );
      } else {
        return ApiResult.error('Invalid response format');
      }
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }
}
