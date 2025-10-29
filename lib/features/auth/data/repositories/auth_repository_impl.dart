import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:slot_booking_app/features/auth/data/data_sources/auth_data_sources.dart';
import 'package:slot_booking_app/features/auth/data/repositories/auth_repository.dart';
import 'package:slot_booking_app/features/auth/domain/entities/token_entity.dart';
import 'package:slot_booking_app/core/helpers/network_info_helper.dart';
import 'package:slot_booking_app/features/auth/domain/entities/user_entity.dart';
import 'package:slot_booking_app/utils/app_exceptions.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({required this.remote, required this.networkInfo});

  @override
  Future<Either<Failure, Token>> login(String email, String password) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet'));
    }
    try {
      final dto = await remote.login(email, password);
      return Right(dto.toDomain());
    } on DioException catch (e) {
      return Left(
        ServerFailure(e.response?.data["message"] ?? "Network error occurred"),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Token>> register(
    String name,
    String email,
    String password,
    bool isDoctor,
    String hospital,
  ) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet'));
    }
    try {
      final dto = await remote.register(
        name,
        email,
        password,
        isDoctor,
        hospital,
      );
      return Right(dto.toDomain());
    } on DioException catch (e) {
      return Left(
        ServerFailure(e.response?.data["message"] ?? "Network error occurred"),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet'));
    }
    try {
      final dto = await remote.getUser();
      return Right(UserEntity.fromJson(dto.toJson()));
    } on DioException catch (e) {
      return Left(
        ServerFailure(e.response?.data["message"] ?? "Network error occurred"),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
