import 'package:bloc_practice/features/products/domain/entities/product_enity.dart';
import 'package:dart_either/dart_either.dart';

abstract class ProductRepository {
  Future<Either<Exception, List<ProductEntity>>> loadProductData();
}
