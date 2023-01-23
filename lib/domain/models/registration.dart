
import 'package:json_annotation/json_annotation.dart';

part 'registration.g.dart';

@JsonSerializable()
class Registration {
  final String nickName;
  final String email;
  final String password;
  final String retryPassword;
  final DateTime birthDate;
  final String phoneNumber;
  final String givenName;
  final String? surname;
  final String country;
  final String gender;

  Registration(
      {required this.nickName,
      required this.email,
      required this.password,
      required this.retryPassword,
      required this.birthDate,
      required this.phoneNumber,
      required this.givenName,
      this.surname,
      required this.country,
      required this.gender});

  factory Registration.fromJson(Map<String, dynamic> json) =>
      _$RegistrationFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationToJson(this);

  factory Registration.fromMap(Map<String, dynamic> map) =>
      _$RegistrationFromJson(map);

  Map<String, dynamic> toMap() => _$RegistrationToJson(this);
}
