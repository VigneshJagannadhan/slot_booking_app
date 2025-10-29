import 'package:fpdart/fpdart.dart';
import 'package:slot_booking_app/features/auth/data/repositories/auth_repository.dart';
import 'package:slot_booking_app/features/auth/domain/entities/user_entity.dart';
import 'package:slot_booking_app/utils/app_exceptions.dart';

class GetUserUseCase {
  final AuthRepository repository;

  GetUserUseCase({required this.repository});

  Future<Either<Failure, UserEntity>> call() async {
    return await repository.getUser();
  }
}
