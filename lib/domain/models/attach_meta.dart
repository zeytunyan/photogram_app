import 'package:json_annotation/json_annotation.dart';

part 'attach_meta.g.dart';

@JsonSerializable()
class AttachMeta {
  final String tempId;
  final String name;
  final String mimeType;
  final int size;

  const AttachMeta({
    required this.tempId,
    required this.name,
    required this.mimeType,
    required this.size,
  });

  factory AttachMeta.fromJson(Map<String, dynamic> json) =>
      _$AttachMetaFromJson(json);

  Map<String, dynamic> toJson() => _$AttachMetaToJson(this);
}