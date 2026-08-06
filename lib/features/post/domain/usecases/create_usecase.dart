import 'package:bloc_practice/core/usecases/usecase.dart';
import 'package:bloc_practice/features/post/domain/entities/post_entity.dart';
import 'package:bloc_practice/features/post/domain/repositories/post_repository.dart';
import 'package:dart_either/dart_either.dart';

class CreateUsecase implements Usecase<PostEntity, PostEntity> {
  final PostRepository postRepository;
  CreateUsecase(this.postRepository);
  @override
  Future<Either<Exception, PostEntity>> call(PostEntity postEntity) async {
    return postRepository.createPost(postEntity);
  }
}
