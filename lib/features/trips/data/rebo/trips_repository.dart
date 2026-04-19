import 'package:graduation/core/network/api_result.dart';
import 'package:graduation/features/trips/data/models/agency_trips_model.dart';
import 'package:graduation/features/trips/data/models/trips_model.dart';

 abstract class TripsRepository {
  Future<ApiResult<List<TripsModel>>> getTrips();
  Future<ApiResult<List<AgencyTrips>>> getAgencyTrips();
}

