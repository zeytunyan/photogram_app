// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['id'] as String,
      text: json['text'] as String?,
      authorId: json['authorId'] as String?,
      created: DateTime.parse(json['created'] as String),
      changed: json['changed'] == null
          ? null
          : DateTime.parse(json['changed'] as String),
      repostedId: json['repostedId'] as String?,
      repostsCount: json['repostsCount'] as int,
      likesCount: json['likesCount'] as int,
      commentsCount: json['commentsCount'] as int,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'authorId': instance.authorId,
      'created': instance.created.toIso8601String(),
      'changed': instance.changed?.toIso8601String(),
      'repostedId': instance.repostedId,
      'repostsCount': instance.repostsCount,
      'likesCount': instance.likesCount,
      'commentsCount': instance.commentsCount,
    };
