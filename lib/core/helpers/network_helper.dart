import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:slot_booking_app/core/helpers/network_info_helper.dart';
import 'package:slot_booking_app/utils/app_exceptions.dart';

class NetworkHelper {
  static Future<Either<Failure, T>> handleRepositoryApiCall<T>({
    required NetworkInfo networkInfo,
    required Future<T> Function() function,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      final result = await function();
      return Right(result);
    } on DioException catch (e) {
      return _handleDioException(e);
    } catch (e) {
      return _handleGenericException(e);
    }
  }

  static Left<Failure, Never> _handleDioException(DioException e) {
    final statusCode = e.response?.statusCode;
    final message = _extractErrorMessage(e);

    switch (statusCode) {
      case 401:
      case 403:
        return Left(UnauthorizedFailure(message));

      case 408:
      case 504:
        return Left(const NetworkFailure('Request timeout'));

      case 500:
      case 502:
      case 503:
        return Left(ServerFailure('Server error occurred'));

      case 404:
        return Left(ServerFailure('Resource not found'));

      default:
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.sendTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          return Left(const NetworkFailure('Connection timeout'));
        }

        if (e.type == DioExceptionType.connectionError) {
          return Left(const NetworkFailure('Cannot reach server'));
        }

        return Left(ServerFailure(message));
    }
  }

  static Left<Failure, Never> _handleGenericException(dynamic e) {
    return Left(UnknownFailure('An unexpected error occurred'));
  }

  static String _extractErrorMessage(DioException e) {
    try {
      final data = e.response?.data;
      if (data is Map && data.containsKey('message')) {
        return data['message'] as String;
      }
      if (data is Map && data.containsKey('error')) {
        return data['error'] as String;
      }
    } catch (_) {}

    return 'Network request failed';
  }
}
