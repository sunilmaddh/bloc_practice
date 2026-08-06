import 'package:bloc_practice/core/usecases/usecase.dart';
import 'package:bloc_practice/features/products/domain/entities/product_enity.dart';
import 'package:bloc_practice/features/products/domain/reposotories/product_repository.dart';
import 'package:dart_either/dart_either.dart';

class ProductLoadUsecase implements Usecase<List<ProductEntity>, NoParams> {
  final ProductRepository repository;
  ProductLoadUsecase({required this.repository});
  @override
  Future<Either<Exception, List<ProductEntity>>> call(NoParams param) async {
    return await repository.loadProductData();
  }
}
