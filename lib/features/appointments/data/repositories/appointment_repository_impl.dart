import 'package:fpdart/fpdart.dart';
import 'package:slot_booking_app/core/helpers/network_helper.dart';
import 'package:slot_booking_app/core/helpers/network_info_helper.dart';
import 'package:slot_booking_app/features/appointments/data/data_sources/appointment_data_source.dart';
import 'package:slot_booking_app/features/appointments/data/models/appointment_model.dart';
import 'package:slot_booking_app/features/appointments/domain/entities/appointments_entity.dart';
import 'package:slot_booking_app/features/appointments/domain/entities/appointments_list_entity.dart';
import 'package:slot_booking_app/features/appointments/domain/repositories/appointment_repository.dart';
import 'package:slot_booking_app/utils/app_exceptions.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentDataSource remote;
  final NetworkInfo networkInfo;

  AppointmentRepositoryImpl({required this.remote, required this.networkInfo});

  @override
  Future<Either<Failure, AppointmentListEntity>> getAppointments({
    int page = 1,
  }) async {
    return await NetworkHelper.handleRepositoryApiCall<AppointmentListEntity>(
      networkInfo: networkInfo,
      function: () async {
        final dto = await remote.getAppointments(page: page);
        return dto.toDomain();
      },
    );
  }

  @override
  Future<Either<Failure, AppointmentEntity>> createAppointment({
    required AppointmentEntity appointment,
  }) async => await NetworkHelper.handleRepositoryApiCall<AppointmentEntity>(
    networkInfo: networkInfo,
    function: () async {
      final dto = await remote.createAppointment(
        appointment: AppointmentModel.fromDomain(appointment),
      );
      return dto.toDomain();
    },
  );

  @override
  Future<Either<Failure, AppointmentEntity>> deleteAppointment({
    required String id,
  }) async => await NetworkHelper.handleRepositoryApiCall<AppointmentEntity>(
    networkInfo: networkInfo,
    function: () async {
      final dto = await remote.deleteAppointment(id: id);
      return dto.toDomain();
    },
  );

  @override
  Future<Either<Failure, AppointmentEntity>> updateAppointment({
    required AppointmentEntity appointment,
  }) async => await NetworkHelper.handleRepositoryApiCall<AppointmentEntity>(
    networkInfo: networkInfo,
    function: () async {
      final dto = await remote.updateAppointment(
        appointment: AppointmentModel.fromDomain(appointment),
      );
      return dto.toDomain();
    },
  );
}
