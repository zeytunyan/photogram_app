// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_create_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCreateModel _$PostCreateModelFromJson(Map<String, dynamic> json) =>
    PostCreateModel(
      authorId: json['authorId'] as String?,
      text: json['text'] as String?,
      contents: (json['contents'] as List<dynamic>)
          .map((e) => AttachMeta.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostCreateModelToJson(PostCreateModel instance) =>
    <String, dynamic>{
      'authorId': instance.authorId,
      'text': instance.text,
      'contents': instance.contents,
    };
