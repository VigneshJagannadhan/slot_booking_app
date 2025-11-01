import 'package:dio/dio.dart';
import 'package:slot_booking_app/core/helpers/shared_preferences_helper.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(String baseUrl, {BaseOptions? options})
    : _dio = Dio(options ?? BaseOptions(baseUrl: baseUrl))
        ..interceptors.add(
          LogInterceptor(
            responseBody: true,
            requestBody: true,
            requestHeader: true,
            request: true,
          ),
        );

  CancelToken newCancelToken() => CancelToken();

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final token = await SharedPreferencesHelper.getUserToken();
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: Options(headers: {"Authorization": token}),
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final token = await SharedPreferencesHelper.getUserToken();
    return _dio.post<T>(
      path,
      data: data,
      options: Options(headers: {"Authorization": token}),
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final token = await SharedPreferencesHelper.getUserToken();
    return _dio.put<T>(
      path,
      data: data,
      options: Options(headers: {"Authorization": token}),
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final token = await SharedPreferencesHelper.getUserToken();
    return _dio.delete<T>(
      path,
      options: Options(headers: {"Authorization": token}),
      cancelToken: cancelToken,
    );
  }
}
