// lib/features/doctors/data/repositories/doctor_repository.dart
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:slot_booking_app/core/helpers/network_info_helper.dart';
import 'package:slot_booking_app/features/home/data/data_sources/doctor_remote_data_source.dart';
import 'package:slot_booking_app/features/home/domain/entities/doctor_list_entity.dart';
import 'package:slot_booking_app/utils/app_exceptions.dart';

abstract class DoctorRepository {
  Future<Either<Failure, DoctorList>> getDoctors({int page = 1});
}

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorRemoteDataSource remote;
  final NetworkInfo networkInfo;

  DoctorRepositoryImpl({required this.remote, required this.networkInfo});

  @override
  Future<Either<Failure, DoctorList>> getDoctors({int page = 1}) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      final dto = await remote.getDoctors(page: page);
      return Right(dto.toDomain());
    } on DioException catch (e) {
      return Left(
        ServerFailure(e.response?.data["message"] ?? "Failed to load doctors"),
      );
    } catch (e) {
      return Left(UnknownFailure("Unexpected error occurred"));
    }
  }
}
