import 'package:fpdart/fpdart.dart';
import 'package:slot_booking_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:slot_booking_app/features/auth/domain/entities/token_entity.dart';
import 'package:slot_booking_app/utils/app_exceptions.dart';

class LoginUseCase {
  final AuthRepository repo;
  LoginUseCase(this.repo);

  Future<Either<Failure, TokenEntity>> call(String email, String password) =>
      repo.login(email, password);
}
