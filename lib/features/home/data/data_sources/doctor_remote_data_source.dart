import 'package:slot_booking_app/core/services/api_service.dart';
import 'package:slot_booking_app/features/home/data/models/doctor_list_dto.dart';
import 'package:slot_booking_app/utils/app_urls.dart';

abstract class DoctorRemoteDataSource {
  Future<DoctorListDto> getDoctors({int page = 1});
}

class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  final ApiClient client;

  DoctorRemoteDataSourceImpl(this.client);

  @override
  Future<DoctorListDto> getDoctors({int page = 1}) async {
    final response = await client.get(
      AppUrls.doctors,
      queryParameters: {'page': page},
    );
    return DoctorListDto.fromJson(response.data);
  }
}
