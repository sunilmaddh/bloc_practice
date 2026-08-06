import 'package:bloc_practice/features/post/domain/entities/post_entity.dart';
import 'package:dart_either/dart_either.dart';

abstract class PostRepository {
  Future<Either<Exception, List<PostEntity>>> getPost();
  Future<Either<Exception, PostEntity>> createPost(PostEntity entity);
}
