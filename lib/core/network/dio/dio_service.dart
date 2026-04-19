import 'package:dio/dio.dart';

import '../api_consumer.dart';
import '../api_error.dart';

class DioService implements ApiConsumer {
  Dio dio;

  DioService(this.dio);

  @override
  Future get(String url, {Map<String,  dynamic>? queryParameters, }) async {
    try {
      var response = await dio.get(url, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  @override
  Future post(String url, {Map<String, dynamic>? body,Options? options})async {
    try {
      var response = await dio.post(url, data: body,options: options);
      return response.data;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

}