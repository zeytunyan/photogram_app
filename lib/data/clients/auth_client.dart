import 'package:photogram_app/domain/models/refresh_token_request.dart';
import 'package:photogram_app/domain/models/token_request.dart';
import 'package:photogram_app/domain/models/token_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/models/registration.dart';

part 'auth_client.g.dart';

@RestApi()
abstract class AuthClient {
  factory AuthClient(Dio dio, {String? baseUrl}) = _AuthClient;

  @POST("/api/Auth/Token")
  Future<TokenResponse?> getToken(@Body() TokenRequest body);

  @POST("/api/Auth/RefreshToken")
  Future<TokenResponse?> refreshToken(@Body() RefreshTokenRequest body);

  @POST("/api/Auth/RegisterUser")
  Future registerUser(@Body() Registration model);
}
