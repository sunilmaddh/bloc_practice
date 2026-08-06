import 'package:bloc_practice/features/post/domain/entities/post_entity.dart';

abstract class PostEvent {}

class PostFetchEvent extends PostEvent {}

class PostCreateEvent extends PostEvent {
  final PostEntity postEntity;
  PostCreateEvent(this.postEntity);
}
