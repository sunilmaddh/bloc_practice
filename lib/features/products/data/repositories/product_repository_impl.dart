import 'package:bloc_practice/features/products/data/datasources/product_remote_datasource.dart';
import 'package:bloc_practice/features/products/data/model/product_model.dart';
import 'package:bloc_practice/features/products/domain/reposotories/product_repository.dart';
import 'package:dart_either/dart_either.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDatasource datasource;
  ProductRepositoryImpl(this.datasource);
  @override
  Future<Either<Exception, List<ProductModel>>> loadProductData() async {
    return await datasource.loadData();
  }
}
