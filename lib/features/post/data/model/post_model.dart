import 'package:bloc_practice/features/post/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  PostModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.body,
  });

  factory PostModel.fromEntity(PostEntity postEnity) {
    return PostModel(
      id: postEnity.id,
      userId: postEnity.userId,
      title: postEnity.title,
      body: postEnity.body,
    );
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? 0,
      userId: json["userId"] ?? 0,
      title: json["title"] ?? "",
      body: json["body"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'userId': userId, 'title': title, 'body': body};
  }
}
