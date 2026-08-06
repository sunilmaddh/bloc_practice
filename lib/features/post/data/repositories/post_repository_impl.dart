import 'package:bloc_practice/features/post/data/datasource/post_remote_datasource.dart';
import 'package:bloc_practice/features/post/data/model/post_model.dart';
import 'package:bloc_practice/features/post/domain/entities/post_entity.dart';
import 'package:bloc_practice/features/post/domain/repositories/post_repository.dart';
import 'package:dart_either/dart_either.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDatasource postRemoteDataSoursce;
  PostRepositoryImpl(this.postRemoteDataSoursce);
  @override
  Future<Either<Exception, PostEntity>> createPost(PostEntity model) async {
    return postRemoteDataSoursce.createPost(PostModel.fromEntity(model));
  }

  @override
  Future<Either<Exception, List<PostModel>>> getPost() {
    return postRemoteDataSoursce.getPosts();
  }
}
