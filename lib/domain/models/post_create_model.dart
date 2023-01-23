import 'package:photogram_app/domain/models/attach_meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_create_model.g.dart';

@JsonSerializable()
class PostCreateModel {
  String? authorId;
  String? text;
  List<AttachMeta> contents;

  PostCreateModel({
    this.authorId,
    this.text,
    required this.contents,
  });

  factory PostCreateModel.fromJson(Map<String, dynamic> json) =>
      _$PostCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostCreateModelToJson(this);
}
