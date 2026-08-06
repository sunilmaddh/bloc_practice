import 'package:bloc_practice/core/network/api_service.dart';
import 'package:bloc_practice/features/products/data/datasources/product_remote_datasource.dart';
import 'package:bloc_practice/features/products/data/model/product_model.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';

class ProductRemoteDatasourceImpl extends ProductRemoteDatasource {
  final ApiService apiService;
  ProductRemoteDatasourceImpl({required this.apiService});
  @override
  Future<Either<Exception, List<ProductModel>>> loadData() async {
    try {
      final result = await apiService.sendRequest.get("/products");
      if (result.statusCode == 200) {
        List<ProductModel> prod = (result.data as List)
            .map((v) => ProductModel.fromJson(v))
            .toList();
        return Right(prod);
      } else {
        return Left(Exception("Something went wrong"));
      }
    } on DioException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
