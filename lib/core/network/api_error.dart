import 'package:dio/dio.dart';

Exception handleDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionError:
      return Exception("Connection error: ${e.message}");
    case DioExceptionType.badResponse:
      return Exception("Invalid response from server: ${e.response?.data}");
    case DioExceptionType.cancel:
      return Exception("Request was cancelled.");
    default:
      return Exception("Unexpected error: ${e.message}");
  }
}