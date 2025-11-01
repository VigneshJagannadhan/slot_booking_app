// lib/features/doctors/data/repositories/doctor_repository.dart
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:slot_booking_app/core/helpers/network_info_helper.dart';
import 'package:slot_booking_app/features/appointments/data/data_sources/appointment_data_source.dart';
import 'package:slot_booking_app/features/appointments/data/models/appointment_dto.dart';
import 'package:slot_booking_app/features/appointments/domain/entities/appointments_entity.dart';
import 'package:slot_booking_app/features/appointments/domain/entities/appointments_list_entity.dart';
import 'package:slot_booking_app/utils/app_exceptions.dart';

abstract class AppointmentRepository {
  Future<Either<Failure, AppointmentList>> getAppointments({int page = 1});
  Future<Either<Failure, Appointment>> createAppointment({
    required Appointment appointment,
  });
  Future<Either<Failure, Appointment>> updateAppointment({
    required Appointment appointment,
  });
  Future<Either<Failure, Appointment>> deleteAppointment({required String id});
}

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentDataSource remote;
  final NetworkInfo networkInfo;

  AppointmentRepositoryImpl({required this.remote, required this.networkInfo});

  @override
  Future<Either<Failure, AppointmentList>> getAppointments({
    int page = 1,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      final dto = await remote.getAppointments(page: page);
      return Right(dto.toDomain());
    } on DioException catch (e) {
      return Left(
        ServerFailure(e.response?.data["message"] ?? "Failed to load doctors"),
      );
    } catch (e) {
      return Left(UnknownFailure("Unexpected error occurred"));
    }
  }

  @override
  Future<Either<Failure, Appointment>> createAppointment({
    required Appointment appointment,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    final appointmentDto = AppointmentDto.fromDomain(appointment);

    try {
      final dto = await remote.createAppointment(appointment: appointmentDto);
      return Right(dto.toDomain());
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data["message"] ?? "Failed to create appointment",
        ),
      );
    } catch (e) {
      return Left(UnknownFailure("Unexpected error occurred"));
    }
  }

  @override
  Future<Either<Failure, Appointment>> deleteAppointment({
    required String id,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      final dto = await remote.deleteAppointment(id: id);
      return Right(dto.toDomain());
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data["message"] ?? "Failed to delete appointment",
        ),
      );
    } catch (e) {
      return Left(UnknownFailure("Unexpected error occurred"));
    }
  }

  @override
  Future<Either<Failure, Appointment>> updateAppointment({
    required Appointment appointment,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }

    final appointmentDto = AppointmentDto.fromDomain(appointment);

    try {
      final dto = await remote.updateAppointment(appointment: appointmentDto);
      return Right(dto.toDomain());
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data["message"] ?? "Failed to update appointment",
        ),
      );
    } catch (e) {
      return Left(UnknownFailure("Unexpected error occurred"));
    }
  }
}
