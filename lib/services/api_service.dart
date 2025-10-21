import 'package:dio/dio.dart' as dio_import;
import 'package:flutter/material.dart';
import 'package:slot_booking_app/helpers/shared_preferences_helper.dart';
import 'package:slot_booking_app/utils/app_urls.dart';

class APIService {
  static final APIService _instance = APIService._initialise();

  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  APIService._initialise()
    : _dio = dio_import.Dio(dio_import.BaseOptions())
        ..interceptors.add(
          dio_import.LogInterceptor(
            responseBody: true,
            requestBody: true,
            requestHeader: true,
            request: true,
          ),
        );

  factory APIService() => _instance;
  final dio_import.Dio _dio;
  dio_import.Dio get dio => _dio;

  Map<String, String> createHeaders() {
    String? token = SharedPreferencesHelper.getUserToken();
    return {"Authorization": token ?? ""};
  }

  Future<Map<String, dynamic>> getDataFromDio({
    required String endPoint,
    dynamic payload,
    Map<String, dynamic>? query,
  }) async {
    try {
      String url = AppUrls.baseUrl + endPoint;
      var response = await dio.get(
        url,
        options: dio_import.Options(headers: createHeaders()),
        queryParameters: query,
        data: payload,
      );

      if (response.statusCode == 200) {
        return response.data ?? {};
      } else {
        throw dio_import.DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Request failed with status: ${response.statusCode}',
        );
      }
    } on dio_import.DioException {
      rethrow;
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> putDataFromDio({
    required String endPoint,
    dynamic payload,
    Map<String, dynamic>? query,
  }) async {
    try {
      String url = AppUrls.baseUrl + endPoint;
      var response = await dio.put(
        url,
        data: payload,
        options: dio_import.Options(headers: createHeaders()),
        queryParameters: query,
      );

      if (response.statusCode == 200) {
        return response.data ?? {};
      } else {
        throw dio_import.DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Request failed with status: ${response.statusCode}',
        );
      }
    } on dio_import.DioException {
      rethrow;
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> postDataFromDio({
    required String endPoint,
    dynamic payload,
    Map<String, dynamic>? query,
  }) async {
    try {
      String url = AppUrls.baseUrl + endPoint;
      var response = await dio.post(
        url,
        data: payload,
        options: dio_import.Options(headers: createHeaders()),
        queryParameters: query,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data ?? {};
      } else {
        throw dio_import.DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Request failed with status: ${response.statusCode}',
        );
      }
    } on dio_import.DioException {
      rethrow;
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> deleteDataFromDio({
    required String endPoint,
    dynamic payload,
    Map<String, dynamic>? query,
  }) async {
    try {
      String url = AppUrls.baseUrl + endPoint;
      var response = await dio.delete(
        url,
        options: dio_import.Options(headers: createHeaders()),
        queryParameters: query,
        data: payload,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return response.data ?? {};
      } else {
        throw dio_import.DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Request failed with status: ${response.statusCode}',
        );
      }
    } on dio_import.DioException {
      rethrow;
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future getDataDioExternal({
    required String endPoint,
    dynamic payload,
    Map<String, dynamic>? query,
    Map<String, dynamic>? header,
  }) async {
    String url = endPoint;
    var response = await dio.get(
      url,
      data: payload,
      options: dio_import.Options(headers: header),
      queryParameters: query,
    );
    if (response.statusCode == 200) {
      return response.data ?? {};
    } else {
      throw Exception('Failed to get data: ${response.data}');
    }
  }

  Future postDataDioExternal({
    required String endPoint,
    dynamic payload,
    Map<String, dynamic>? query,
    Map<String, dynamic>? header,
  }) async {
    String url = endPoint;
    var response = await dio.post(
      url,
      data: payload,
      options: dio_import.Options(headers: header),
      queryParameters: query,
    );
    if (response.statusCode == 200) {
      return response.data ?? {};
    } else {
      throw Exception('Failed to post data: ${response.data}');
    }
  }
}
