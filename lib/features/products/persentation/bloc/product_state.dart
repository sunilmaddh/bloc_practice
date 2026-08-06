import 'package:bloc_practice/features/products/domain/entities/product_enity.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  List<ProductEntity> productModel;
  ProductLoadedState(this.productModel);
}

class ProductErrorState extends ProductState {
  final String error;
  ProductErrorState(this.error);
}
