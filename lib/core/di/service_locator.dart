import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:slot_booking_app/features/auth/data/repositories/auth_repository.dart';
import 'package:slot_booking_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:slot_booking_app/features/auth/data/data_sources/auth_data_sources.dart';
import 'package:slot_booking_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:slot_booking_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:slot_booking_app/features/auth/presentation/bloc/visibility/visibility_bloc.dart';
import 'package:slot_booking_app/core/helpers/network_info_helper.dart';
import 'package:slot_booking_app/core/services/api_service.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // External dependencies
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: dotenv.env['BASE_URL'] ?? 'http://localhost:8080/api/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    ),
  );

  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  // Network info
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<Connectivity>()),
  );

  // API Client
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(dotenv.env['BASE_URL'] ?? 'http://localhost:8080/api/'),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<ApiClient>()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remote: sl<AuthRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // Use cases
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(sl<AuthRepository>()),
  );

  // Blocs
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(login: sl<LoginUseCase>(), register: sl<RegisterUseCase>()),
  );

  sl.registerFactory<VisibilityBloc>(() => VisibilityBloc());
}
