import 'package:json_annotation/json_annotation.dart';
import 'package:photogram_app/domain/db_model.dart';

part 'user.g.dart';

@JsonSerializable()
class User implements DbModel {
  @override
  final String id;
  final String nickName;
  final String? avatarLink;
  final String fullName;
  final String? profession;
  final String? status;
  final int postsCount;
  final int followersCount;
  final int followingsCount;

  User({
    required this.id,
    required this.nickName,
    required this.avatarLink,
    required this.fullName,
    required this.profession,
    required this.status,
    required this.postsCount,
    required this.followersCount,
    required this.followingsCount,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.fromMap(Map<String, dynamic> map) => _$UserFromJson(map);

  @override
  Map<String, dynamic> toMap() => _$UserToJson(this);
}
