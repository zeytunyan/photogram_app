// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      id: json['id'] as String,
      text: json['text'] as String?,
      created: DateTime.parse(json['created'] as String),
      changed: json['changed'] == null
          ? null
          : DateTime.parse(json['changed'] as String),
      repostedId: json['repostedId'] as String?,
      repostsCount: json['repostsCount'] as int,
      likesCount: json['likesCount'] as int,
      commentsCount: json['commentsCount'] as int,
      author: UserShort.fromJson(json['author'] as Map<String, dynamic>),
      contents: (json['contents'] as List<dynamic>)
          .map((e) => PostContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'created': instance.created.toIso8601String(),
      'changed': instance.changed?.toIso8601String(),
      'repostedId': instance.repostedId,
      'repostsCount': instance.repostsCount,
      'likesCount': instance.likesCount,
      'commentsCount': instance.commentsCount,
      'author': instance.author,
      'contents': instance.contents,
    };
