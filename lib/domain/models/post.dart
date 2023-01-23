import 'package:photogram_app/domain/db_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post implements DbModel {
  @override
  final String id;
  final String? text;
  final String? authorId;
  final DateTime created;
  final DateTime? changed;
  final String? repostedId;
  final int repostsCount;
  final int likesCount;
  final int commentsCount;

  Post({
    required this.id,
    required this.text,
    this.authorId,
    required this.created,
    required this.changed,
    required this.repostedId,
    required this.repostsCount,
    required this.likesCount,
    required this.commentsCount,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  factory Post.fromMap(Map<String, dynamic> map) => _$PostFromJson(map);
  @override
  Map<String, dynamic> toMap() => _$PostToJson(this);

  Post copyWith({
    String? id,
    String? text,
    String? authorId,
    DateTime? created,
    DateTime? changed,
    String? repostedId,
    int? repostsCount,
    int? likesCount,
    int? commentsCount,
  }) {
    return Post(
      id: id ?? this.id,
      text: text ?? this.text,
      authorId: authorId ?? this.authorId,
      created: created ?? this.created,
      changed: changed ?? this.changed,
      repostedId: repostedId ?? this.repostedId,
      repostsCount: repostsCount ?? this.repostsCount,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
    );
  }
}
