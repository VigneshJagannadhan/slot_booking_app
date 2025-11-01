import 'package:slot_booking_app/core/services/api_service.dart';
import 'package:slot_booking_app/features/appointments/data/models/appointment_dto.dart';
import 'package:slot_booking_app/features/appointments/data/models/appointments_list_dto.dart';
import 'package:slot_booking_app/utils/app_urls.dart';

abstract class AppointmentDataSource {
  Future<AppointmentListDto> getAppointments({required int page});
  Future<AppointmentDto> createAppointment({
    required AppointmentDto appointment,
  });
  Future<AppointmentDto> deleteAppointment({required String id});
  Future<AppointmentDto> updateAppointment({
    required AppointmentDto appointment,
  });
}

class AppointmentDataSourceImpl extends AppointmentDataSource {
  final ApiClient client;
  AppointmentDataSourceImpl(this.client);

  @override
  Future<AppointmentListDto> getAppointments({required int page}) async {
    final response = await client.get(
      AppUrls.appointments,
      queryParameters: {"page": page},
    );

    return AppointmentListDto.fromJson(response.data);
  }

  @override
  Future<AppointmentDto> createAppointment({
    required AppointmentDto appointment,
  }) async {
    final response = await client.post(
      AppUrls.appointments,
      data: appointment.toJson(),
    );
    return AppointmentDto.fromJson(response.data);
  }

  @override
  Future<AppointmentDto> deleteAppointment({required String id}) async {
    final response = await client.delete(AppUrls.appointments + "/$id");
    return AppointmentDto.fromJson(response.data);
  }

  @override
  Future<AppointmentDto> updateAppointment({
    required AppointmentDto appointment,
  }) async {
    final response = await client.put(
      '${AppUrls.appointments}/${appointment.id}',
      data: appointment.toJson(),
    );
    return AppointmentDto.fromJson(response.data);
  }
}
