import 'package:bloc_practice/core/usecases/usecase.dart';
import 'package:bloc_practice/features/post/domain/usecases/create_usecase.dart';
import 'package:bloc_practice/features/post/domain/usecases/get_usecase.dart';
import 'package:bloc_practice/features/post/persentation/bloc/post_event.dart';
import 'package:bloc_practice/features/post/persentation/bloc/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetUsecase getUsecase;
  final CreateUsecase createUsecase;
  PostBloc(this.getUsecase, this.createUsecase) : super(PostIntialState()) {
    on<PostFetchEvent>(((event, emit) async {
      emit(PostLoadingState());
      final result = await getUsecase.call(NoParams());
      result.fold(
        ifLeft: (failure) {
          emit(PostErrorState(error: failure.toString()));
        },
        ifRight: (posts) {
          emit(PostLoadedState(posts));
        },
      );
    }));
  }
}
