import 'package:json_annotation/json_annotation.dart';
import 'package:photogram_app/domain/db_model.dart';

part 'user_short.g.dart';

@JsonSerializable()
class UserShort implements DbModel {
  @override
  final String id;
  final String nickName;
  final String? avatarLink;
  final String fullName;

  UserShort({
    required this.id,
    required this.nickName,
    required this.avatarLink,
    required this.fullName,
  });

  factory UserShort.fromJson(Map<String, dynamic> json) =>
      _$UserShortFromJson(json);

  Map<String, dynamic> toJson() => _$UserShortToJson(this);

  factory UserShort.fromMap(Map<String, dynamic> map) =>
      _$UserShortFromJson(map);
  @override
  Map<String, dynamic> toMap() => _$UserShortToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserShort &&
        other.id == id &&
        other.nickName == nickName &&
        other.fullName == fullName &&
        other.avatarLink == avatarLink;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nickName.hashCode ^
        fullName.hashCode ^
        avatarLink.hashCode;
  }
}
