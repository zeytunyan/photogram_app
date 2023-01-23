// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_short.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserShort _$UserShortFromJson(Map<String, dynamic> json) => UserShort(
      id: json['id'] as String,
      nickName: json['nickName'] as String,
      avatarLink: json['avatarLink'] as String?,
      fullName: json['fullName'] as String,
    );

Map<String, dynamic> _$UserShortToJson(UserShort instance) => <String, dynamic>{
      'id': instance.id,
      'nickName': instance.nickName,
      'avatarLink': instance.avatarLink,
      'fullName': instance.fullName,
    };
