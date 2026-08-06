import 'package:bloc_practice/features/products/data/model/product_model.dart';
import 'package:dart_either/dart_either.dart';

abstract class ProductRemoteDatasource {
  Future<Either<Exception, List<ProductModel>>> loadData();
}
