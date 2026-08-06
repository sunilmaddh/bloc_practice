import 'package:bloc_practice/core/network/api_service.dart';
import 'package:bloc_practice/features/phone/data/datasources/phone_remote_source.dart';
import 'package:bloc_practice/features/phone/data/model/phone_model.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';

class PhoneRemoteSourceImpl extends PhoneRemoteSource {
  final ApiService apiService;
  PhoneRemoteSourceImpl({required this.apiService});
  @override
  Future<Either<Exception, List<PhoneModel>>> fetchPhoneList() async {
    try {
      final result = await apiService.sendRequest.get("");
      if (result.statusCode == 200) {
        final data = (result.data as List)
            .map((model) => PhoneModel.fromJson(model))
            .toList();
        return Right(data);
      } else {
        return Left(Exception("Something went wrong"));
      }
    } on DioException catch (e) {
      return Left(Exception(e.toString()));
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
