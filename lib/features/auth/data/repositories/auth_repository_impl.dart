import 'package:fpdart/fpdart.dart';
import 'package:slot_booking_app/features/auth/data/data_sources/auth_data_sources.dart';
import 'package:slot_booking_app/features/auth/data/repositories/auth_repository.dart';
import 'package:slot_booking_app/features/auth/domain/entities/token_entity.dart';
import 'package:slot_booking_app/core/helpers/network_info_helper.dart';
import 'package:slot_booking_app/core/utils/app_exceptions.dart';

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
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Token>> register(
    String name,
    String email,
    String password,
  ) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet'));
    }
    try {
      final dto = await remote.register(name, email, password);
      return Right(dto.toDomain());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
