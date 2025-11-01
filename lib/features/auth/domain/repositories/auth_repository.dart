import 'package:fpdart/fpdart.dart';
import 'package:slot_booking_app/features/auth/domain/entities/token_entity.dart';
import 'package:slot_booking_app/features/auth/domain/entities/user_entity.dart';
import 'package:slot_booking_app/utils/app_exceptions.dart';

abstract class AuthRepository {
  Future<Either<Failure, TokenEntity>> login(String email, String password);
  Future<Either<Failure, TokenEntity>> register(
    String name,
    String email,
    String password,
    bool isDoctor,
    String? hospital,
    String? designation,
  );

  Future<Either<Failure, UserEntity>> getUser();
}
