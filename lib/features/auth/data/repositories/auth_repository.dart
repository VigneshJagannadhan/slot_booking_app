import 'package:fpdart/fpdart.dart';
import 'package:slot_booking_app/features/auth/domain/entities/token_entity.dart';
import 'package:slot_booking_app/features/auth/domain/entities/user_entity.dart';
import 'package:slot_booking_app/utils/app_exceptions.dart';

abstract class AuthRepository {
  Future<Either<Failure, Token>> login(String email, String password);
  Future<Either<Failure, Token>> register(
    String name,
    String email,
    String password,
    bool isDoctor,
    String hospital,
  );

  Future<Either<Failure, UserEntity>> getUser();
}
