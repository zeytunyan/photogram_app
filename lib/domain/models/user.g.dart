// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      nickName: json['nickName'] as String,
      avatarLink: json['avatarLink'] as String?,
      fullName: json['fullName'] as String,
      profession: json['profession'] as String?,
      status: json['status'] as String?,
      postsCount: json['postsCount'] as int,
      followersCount: json['followersCount'] as int,
      followingsCount: json['followingsCount'] as int,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'nickName': instance.nickName,
      'avatarLink': instance.avatarLink,
      'fullName': instance.fullName,
      'profession': instance.profession,
      'status': instance.status,
      'postsCount': instance.postsCount,
      'followersCount': instance.followersCount,
      'followingsCount': instance.followingsCount,
    };
