import 'package:fpdart/fpdart.dart';
import 'package:slot_booking_app/core/helpers/network_helper.dart';
import 'package:slot_booking_app/features/auth/data/data_sources/auth_data_sources.dart';
import 'package:slot_booking_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:slot_booking_app/features/auth/domain/entities/token_entity.dart';
import 'package:slot_booking_app/core/helpers/network_info_helper.dart';
import 'package:slot_booking_app/features/auth/domain/entities/user_entity.dart';
import 'package:slot_booking_app/utils/app_exceptions.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource remote;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({required this.remote, required this.networkInfo});

  @override
  Future<Either<Failure, TokenEntity>> login(
    String email,
    String password,
  ) async => await NetworkHelper.handleRepositoryApiCall<TokenEntity>(
    networkInfo: networkInfo,
    function: () async => (await remote.login(email, password)).toDomain(),
  );

  @override
  Future<Either<Failure, TokenEntity>> register(
    String name,
    String email,
    String password,
    bool isDoctor,
    String? hospital,
    String? designation,
  ) async => await NetworkHelper.handleRepositoryApiCall<TokenEntity>(
    networkInfo: networkInfo,
    function:
        () async =>
            (await remote.register(
              name,
              email,
              password,
              isDoctor,
              hospital,
              designation,
            )).toDomain(),
  );

  @override
  Future<Either<Failure, UserEntity>> getUser() async =>
      await NetworkHelper.handleRepositoryApiCall<UserEntity>(
        networkInfo: networkInfo,
        function: () async => (await remote.getUser()).toDomain(),
      );
}
