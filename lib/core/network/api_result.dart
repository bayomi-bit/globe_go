
class ApiResult<T> {
  T? data;
  String? error;

  ApiResult.success(this.data) : error = null;

  ApiResult.error(this.error) : data = null;

  bool get isSuccess => data != null;

  bool get isError => error != null;
}
