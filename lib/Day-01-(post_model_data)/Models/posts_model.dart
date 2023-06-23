import 'dart:convert';

class PostsModel {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  PostsModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  PostsModel copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) =>
      PostsModel(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
      );

  factory PostsModel.fromRawJson(String str) =>
      PostsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
