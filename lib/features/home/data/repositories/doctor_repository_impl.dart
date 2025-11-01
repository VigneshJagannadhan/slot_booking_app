import 'package:fpdart/fpdart.dart';
import 'package:slot_booking_app/core/helpers/network_helper.dart';
import 'package:slot_booking_app/core/helpers/network_info_helper.dart';
import 'package:slot_booking_app/features/home/data/data_sources/doctor_remote_data_source.dart';
import 'package:slot_booking_app/features/home/domain/repositories/doctor_repository.dart';
import 'package:slot_booking_app/features/home/domain/entities/doctor_list_entity.dart';
import 'package:slot_booking_app/utils/app_exceptions.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorRemoteDataSource remote;
  final NetworkInfo networkInfo;

  DoctorRepositoryImpl({required this.remote, required this.networkInfo});

  @override
  Future<Either<Failure, DoctorListEntity>> getDoctors({int page = 1}) async {
    return await NetworkHelper.handleRepositoryApiCall<DoctorListEntity>(
      networkInfo: networkInfo,
      function: () async => (await remote.getDoctors(page: page)).toDomain(),
    );
  }
}
