import 'package:bloc_practice/core/usecases/usecase.dart';
import 'package:bloc_practice/features/post/domain/entities/post_entity.dart';
import 'package:bloc_practice/features/post/domain/repositories/post_repository.dart';
import 'package:dart_either/dart_either.dart';

class GetUsecase implements Usecase<List<PostEntity>, NoParams> {
  final PostRepository postRepository;
  GetUsecase(this.postRepository);
  @override
  Future<Either<Exception, List<PostEntity>>> call(NoParams noParam) async {
    return postRepository.getPost();
  }
}
