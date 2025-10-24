import 'package:dio/dio.dart';

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
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.post<T>(
      path,
      data: data,
      options: options,
      cancelToken: cancelToken,
    );
  }

  // Add put, delete as needed
}
