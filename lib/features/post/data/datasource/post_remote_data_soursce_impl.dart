import 'dart:convert';

import 'package:bloc_practice/core/network/api_service.dart';
import 'package:bloc_practice/features/post/data/datasource/post_remote_datasource.dart';
import 'package:bloc_practice/features/post/data/model/post_model.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';

class PostRemoteDataSourceImpl implements PostRemoteDatasource {
  final ApiService apiService;
  PostRemoteDataSourceImpl(this.apiService);
  @override
  Future<Either<Exception, PostModel>> createPost(PostModel postModel) async {
    try {
      final response = await apiService.sendRequest.post(
        "posts",
        data: jsonEncode(postModel.toJson()),
      );
      if (response.statusCode == 200) {
        final PostModel posts = PostModel.fromJson(response.data);
        return Right(posts);
      } else {
        return Left(Exception("Failed to fetch"));
      }
    } on DioException catch (ex) {
      return Left(Exception(ex.message));
    } catch (ex) {
      return Left(Exception(ex.toString()));
    }
  }

  @override
  Future<Either<Exception, List<PostModel>>> getPosts() async {
    try {
      final response = await apiService.sendRequest.get("posts");
      if (response.statusCode == 200) {
        final List<PostModel> posts = (response.data as List)
            .map((post) => PostModel.fromJson(post))
            .toList();
        return Right(posts);
      } else {
        return Left(Exception("Failed to fetch"));
      }
    } on DioException catch (ex) {
      return Left(Exception(ex.message));
    } catch (ex) {
      return Left(Exception(ex.toString()));
    }
  }
}
