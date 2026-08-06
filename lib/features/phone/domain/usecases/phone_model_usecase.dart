import 'package:bloc_practice/core/usecases/usecase.dart';
import 'package:bloc_practice/features/phone/domain/entities/phone_entity.dart';
import 'package:bloc_practice/features/phone/domain/repositories/phone_model_list_repositories.dart';
import 'package:dart_either/dart_either.dart';

class PhoneModelUsecase implements Usecase<List<PhoneEntity>, NoParams> {
  final PhoneModelListRepositories phoneModelListRepositories;
  PhoneModelUsecase({required this.phoneModelListRepositories});
  @override
  Future<Either<Exception, List<PhoneEntity>>> call(param) {
    return phoneModelListRepositories.fetchPhoneList();
  }
}
