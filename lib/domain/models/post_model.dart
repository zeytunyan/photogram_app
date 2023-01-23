import 'package:photogram_app/domain/models/post_content.dart';
import 'package:photogram_app/domain/models/user_short.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  String id;
  String? text;
  DateTime created;
  DateTime? changed;
  String? repostedId;
  int repostsCount;
  int likesCount;
  int commentsCount;
  UserShort author;
  List<PostContent> contents;

  PostModel({
    required this.id,
    this.text,
    required this.created,
    this.changed,
    this.repostedId,
    required this.repostsCount,
    required this.likesCount,
    required this.commentsCount,
    required this.author,
    required this.contents,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
