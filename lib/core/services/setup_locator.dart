import 'package:bloc_practice/core/network/api_service.dart';
import 'package:bloc_practice/features/home/bloc/internet_bloc.dart';
import 'package:bloc_practice/features/products/data/datasources/product_remote_datasource.dart';
import 'package:bloc_practice/features/products/data/datasources/product_remote_datasource_impl.dart';
import 'package:bloc_practice/features/products/data/repositories/product_repository_impl.dart';
import 'package:bloc_practice/features/products/domain/reposotories/product_repository.dart';
import 'package:bloc_practice/features/products/domain/usecases/product_usecase.dart';
import 'package:bloc_practice/features/products/persentation/bloc/product_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<ProductRemoteDatasource>(
    () => ProductRemoteDatasourceImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(getIt<ProductRemoteDatasource>()),
  );
  getIt.registerLazySingleton<ProductLoadUsecase>(
    () => ProductLoadUsecase(repository: getIt<ProductRepository>()),
  );
  getIt.registerFactory<ProductBloc>(
    () => ProductBloc(getIt<ProductLoadUsecase>()),
  );
  getIt.registerFactory<InternetBloc>(() => InternetBloc());
}
