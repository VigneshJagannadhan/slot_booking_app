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

  Future getDataFromDio({
    required String endPoint,
    dynamic payload,
    Map<String, dynamic>? query,
    bool isRegistration = false,
    bool isAccessToken = false,
  }) async {
    String url = AppUrls.baseUrl + endPoint;
    return await dio.get(
      url,
      options: dio_import.Options(headers: createHeaders()),
      queryParameters: query,
      data: payload,
    );
  }

  Future putDataFromDio({
    required String endPoint,
    dynamic payload,
    Map<String, dynamic>? query,
    bool isRegistration = false,
    bool isAccessToken = false,
  }) async {
    String url = AppUrls.baseUrl + endPoint;
    return await dio.put(
      url,
      data: payload,
      options: dio_import.Options(headers: createHeaders()),
      queryParameters: query,
    );
  }

  Future postDataFromDio({
    required String endPoint,
    dynamic payload,
    Map<String, dynamic>? query,
    bool isRegistration = false,
    bool isAccessToken = false,
  }) async {
    String url = AppUrls.baseUrl + endPoint;
    return await dio.post(
      url,
      data: payload,
      options: dio_import.Options(headers: createHeaders()),
      queryParameters: query,
    );
  }

  Future deleteDataFromDio({
    required String endPoint,
    dynamic payload,
    Map<String, dynamic>? query,
    bool isRegistration = false,
    bool isAccessToken = false,
  }) async {
    String url = AppUrls.baseUrl + endPoint;
    return await dio.delete(
      url,
      options: dio_import.Options(headers: createHeaders()),
      queryParameters: query,
      data: payload,
    );
  }

  Future getDataDioExternal({
    required String endPoint,
    dynamic payload,
    Map<String, dynamic>? query,
    Map<String, dynamic>? header,
    bool isRegistration = false,
  }) async {
    String url = endPoint;
    return await dio.get(
      url,
      data: payload,
      options: dio_import.Options(headers: header),
      queryParameters: query,
    );
  }

  Future postDataDioExternal({
    required String endPoint,
    dynamic payload,
    Map<String, dynamic>? query,
    Map<String, dynamic>? header,
    bool isRegistration = false,
  }) async {
    String url = endPoint;
    return await dio.post(
      url,
      data: payload,
      options: dio_import.Options(headers: header),
      queryParameters: query,
    );
  }

  // Future putDataImage({
  //   required String presigned,
  //   dynamic payload,
  //   bool isRegistration = false,
  // }) async => await http.put(Uri.parse(presigned), body: payload);
}
