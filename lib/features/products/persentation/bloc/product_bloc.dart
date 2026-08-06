import 'package:bloc_practice/core/usecases/usecase.dart';
import 'package:bloc_practice/features/products/domain/usecases/product_usecase.dart';
import 'package:bloc_practice/features/products/persentation/bloc/product_event.dart';
import 'package:bloc_practice/features/products/persentation/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductLoadUsecase productLoadUsecase;
  ProductBloc(this.productLoadUsecase) : super(ProductInitialState()) {
    on<ProductLoadEvent>(loadProductData);
  }
  Future<void> loadProductData(
    ProductLoadEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());
    var response = await productLoadUsecase.call(NoParams());
    response.fold(
      ifLeft: (value) {
        emit(ProductErrorState(value.toString()));
      },
      ifRight: (value) {
        emit(ProductLoadedState(value));
      },
    );
  }
}
