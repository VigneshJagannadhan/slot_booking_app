import 'package:fpdart/fpdart.dart';
import 'package:slot_booking_app/features/auth/data/repositories/auth_repository.dart';
import 'package:slot_booking_app/features/auth/domain/entities/token_entity.dart';
import 'package:slot_booking_app/utils/app_exceptions.dart';

class RegisterUseCase {
  final AuthRepository repo;
  RegisterUseCase(this.repo);

  Future<Either<Failure, Token>> call(
    String name,
    String email,
    String password,
    bool isDoctor,
  ) => repo.register(name, email, password, isDoctor);
}
