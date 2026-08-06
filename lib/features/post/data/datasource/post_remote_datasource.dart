import 'package:bloc_practice/features/post/data/model/post_model.dart';
import 'package:dart_either/dart_either.dart';

abstract class PostRemoteDatasource {
  Future<Either<Exception, List<PostModel>>> getPosts();
  Future<Either<Exception, PostModel>> createPost(PostModel postModel);
}
