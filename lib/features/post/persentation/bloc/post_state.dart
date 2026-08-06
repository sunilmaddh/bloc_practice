import 'package:bloc_practice/features/post/domain/entities/post_entity.dart';

abstract class PostState {}

class PostIntialState extends PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  final List<PostEntity> post;
  PostLoadedState(this.post);
}

class PostErrorState extends PostState {
  final String error;
  PostErrorState({required this.error});
}
