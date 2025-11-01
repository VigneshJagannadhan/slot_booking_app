import 'package:slot_booking_app/core/services/api_service.dart';
import 'package:slot_booking_app/features/appointments/data/models/appointment_model.dart';
import 'package:slot_booking_app/features/appointments/data/models/appointments_list_model.dart';
import 'package:slot_booking_app/utils/app_urls.dart';

abstract class AppointmentDataSource {
  Future<AppointmentListModel> getAppointments({required int page});
  Future<AppointmentModel> createAppointment({
    required AppointmentModel appointment,
  });
  Future<AppointmentModel> deleteAppointment({required String id});
  Future<AppointmentModel> updateAppointment({
    required AppointmentModel appointment,
  });
}

class AppointmentDataSourceImpl extends AppointmentDataSource {
  final ApiClient client;
  AppointmentDataSourceImpl(this.client);

  @override
  Future<AppointmentListModel> getAppointments({required int page}) async {
    final response = await client.get(
      AppUrls.appointments,
      queryParameters: {"page": page},
    );

    return AppointmentListModel.fromJson(response.data);
  }

  @override
  Future<AppointmentModel> createAppointment({
    required AppointmentModel appointment,
  }) async {
    final response = await client.post(
      AppUrls.appointments,
      data: appointment.toJson(),
    );
    return AppointmentModel.fromJson(response.data);
  }

  @override
  Future<AppointmentModel> deleteAppointment({required String id}) async {
    final response = await client.delete("${AppUrls.appointments}/$id");
    return AppointmentModel.fromJson(response.data);
  }

  @override
  Future<AppointmentModel> updateAppointment({
    required AppointmentModel appointment,
  }) async {
    final response = await client.put(
      '${AppUrls.appointments}/${appointment.id}',
      data: appointment.toJson(),
    );
    return AppointmentModel.fromJson(response.data);
  }
}
