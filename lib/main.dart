import 'package:bloc_practice/core/network/api_service.dart';
import 'package:bloc_practice/core/services/setup_locator.dart';
import 'package:bloc_practice/features/home/products/persentation/screen/product_screen.dart';
import 'package:bloc_practice/features/post/data/datasource/post_remote_data_soursce_impl.dart';
import 'package:bloc_practice/features/post/data/datasource/post_remote_datasource.dart';
import 'package:bloc_practice/features/post/data/repositories/post_repository_impl.dart';
import 'package:bloc_practice/features/post/domain/repositories/post_repository.dart';
import 'package:bloc_practice/features/post/domain/usecases/create_usecase.dart';
import 'package:bloc_practice/features/post/domain/usecases/get_usecase.dart';
import 'package:bloc_practice/features/products/persentation/bloc/product_bloc.dart';
import 'package:bloc_practice/features/products/persentation/bloc/product_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ApiService>(create: (context) => ApiService()),
        RepositoryProvider<PostRemoteDatasource>(
          create: (context) => PostRemoteDataSourceImpl(
            // RepositoryProvider.of<ApiService>(context),
            context.read<ApiService>(),
          ),
        ),
        RepositoryProvider<PostRepository>(
          create: (context) => PostRepositoryImpl(
            context.read<PostRemoteDatasource>(),
            // RepositoryProvider.of<PostRemoteDatasource>(context),
          ),
        ),
        RepositoryProvider<GetUsecase>(
          create: (context) =>
              GetUsecase(RepositoryProvider.of<PostRepository>(context)),
        ),
        RepositoryProvider<CreateUsecase>(
          create: (context) =>
              CreateUsecase(RepositoryProvider.of<PostRepository>(context)),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: BlocProvider(
          create: (context) =>
              // PostBloc(
              //   context.read<GetUsecase>(),
              //   context.read<CreateUsecase>(),
              // )..add(PostFetchEvent()),
              getIt<ProductBloc>()..add(ProductLoadEvent()),
          // ProductBloc(context.read<ProductRepository>())
          //   ..add(ProductLoadEvent()),
          child: ProductScreen(),
        ),
      ),
    );
  }
}
