import 'package:dart_either/dart_either.dart';

abstract class Usecase<T, P> {
  Future<Either<Exception, T>> call(P param);
}

class NoParams {}
