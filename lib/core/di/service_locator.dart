import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:slot_booking_app/features/appointments/data/data_sources/appointment_data_source.dart';
import 'package:slot_booking_app/features/appointments/domain/repositories/appointment_repository.dart';
import 'package:slot_booking_app/features/appointments/data/repositories/appointment_repository_impl.dart';
import 'package:slot_booking_app/features/appointments/domain/usecases/appointment_usecase.dart';
import 'package:slot_booking_app/features/appointments/presentation/blocs/appointment_bloc.dart';
import 'package:slot_booking_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:slot_booking_app/features/auth/data/data_sources/auth_data_sources.dart';
import 'package:slot_booking_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:slot_booking_app/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:slot_booking_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:slot_booking_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:slot_booking_app/core/helpers/network_info_helper.dart';
import 'package:slot_booking_app/core/services/api_service.dart';
import 'package:slot_booking_app/features/home/data/data_sources/doctor_remote_data_source.dart';
import 'package:slot_booking_app/features/home/domain/repositories/doctor_repository.dart';
import 'package:slot_booking_app/features/home/data/repositories/doctor_repository_impl.dart';
import 'package:slot_booking_app/features/home/domain/usecases/get_doctors_usecase.dart';
import 'package:slot_booking_app/features/home/presentation/bloc/doctor_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  ///-------------------------------------------------------------------///
  ///                           EXTERNAL                                ///
  ///-------------------------------------------------------------------///
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: dotenv.env['BASE_URL'] ?? 'http://localhost:8080/api/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    ),
  );

  ///-------------------------------------------------------------------///
  ///                           CONNECTIVITY                            ///
  ///-------------------------------------------------------------------///
  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  ///-------------------------------------------------------------------///
  ///                           NETWORK INFO                            ///
  ///-------------------------------------------------------------------///
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<Connectivity>()),
  );

  ///-------------------------------------------------------------------///
  ///                           API CLIENT                              ///
  ///-------------------------------------------------------------------///
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(dotenv.env['BASE_URL'] ?? 'http://localhost:8080/api/'),
  );

  ///-------------------------------------------------------------------///
  ///                           DATA SOURCES                            ///
  ///-------------------------------------------------------------------///

  sl.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(sl<ApiClient>()),
  );

  sl.registerLazySingleton<DoctorRemoteDataSource>(
    () => DoctorRemoteDataSourceImpl(sl<ApiClient>()),
  );

  sl.registerLazySingleton<AppointmentDataSource>(
    () => AppointmentDataSourceImpl(sl<ApiClient>()),
  );

  ///-------------------------------------------------------------------///
  ///                           REPOSITORIES                            ///
  ///-------------------------------------------------------------------///
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remote: sl<AuthDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  sl.registerLazySingleton<DoctorRepository>(
    () => DoctorRepositoryImpl(
      remote: sl<DoctorRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  sl.registerLazySingleton<AppointmentRepository>(
    () => AppointmentRepositoryImpl(
      remote: sl<AppointmentDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  ///-------------------------------------------------------------------///
  ///                           USECASES                                ///
  ///-------------------------------------------------------------------///
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<GetDoctorsUseCase>(
    () => GetDoctorsUseCase(sl<DoctorRepository>()),
  );

  sl.registerLazySingleton<GetUserUseCase>(
    () => GetUserUseCase(repository: sl<AuthRepository>()),
  );

  sl.registerLazySingleton<GetAppointmentUsecase>(
    () => GetAppointmentUsecase(
      appointmentRepository: sl<AppointmentRepository>(),
    ),
  );

  sl.registerLazySingleton<CreateAppointmentUsecase>(
    () => CreateAppointmentUsecase(
      appointmentRepository: sl<AppointmentRepository>(),
    ),
  );

  sl.registerLazySingleton<UpdateAppointmentUsecase>(
    () => UpdateAppointmentUsecase(
      appointmentRepository: sl<AppointmentRepository>(),
    ),
  );

  sl.registerLazySingleton<DeleteAppointmentUsecase>(
    () => DeleteAppointmentUsecase(
      appointmentRepository: sl<AppointmentRepository>(),
    ),
  );

  ///-------------------------------------------------------------------///
  ///                           BLOCS                                   ///
  ///-------------------------------------------------------------------///
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      login: sl<LoginUseCase>(),
      register: sl<RegisterUseCase>(),
      getUser: sl<GetUserUseCase>(),
    ),
  );

  sl.registerFactory<DoctorBloc>(
    () => DoctorBloc(getDoctorsUseCase: sl<GetDoctorsUseCase>()),
  );

  sl.registerFactory<AppointmentBloc>(
    () => AppointmentBloc(
      appointmentUsecase: sl<GetAppointmentUsecase>(),
      createAppointmentUsecase: sl<CreateAppointmentUsecase>(),
      updateAppointmentUsecase: sl<UpdateAppointmentUsecase>(),
      deleteAppointmentUsecase: sl<DeleteAppointmentUsecase>(),
    ),
  );
}
