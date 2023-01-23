import 'dart:io';
import 'package:photogram_app/data/services/data_service.dart';
import 'package:photogram_app/domain/models/registration.dart';
import 'package:photogram_app/domain/repository/api_repository.dart';
import 'package:photogram_app/internal/config/shared_prefs.dart';
import 'package:photogram_app/internal/config/token_storage.dart';
import 'package:photogram_app/internal/dependencies/repository_module.dart';
import 'package:photogram_app/internal/utils.dart';
//import 'package:photogram_app/domain/models/push_token.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dio/dio.dart';

class AuthService {
  final ApiRepository _api = RepositoryModule.apiRepository();
  final DataService _dataService = DataService();

  Future auth(String? login, String? password) async {
    if (login == null || password == null) {
      return;
    }

    try {
      var token = await _api.getToken(login: login, password: password);
      if (token != null) {
        await TokenStorage.setStoredToken(token);
        var user = await _api.getCurrentUser();
        if (user != null) {
          SharedPrefs.setStoredUser(user);
        }
      }
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw NoNetworkException();
      } else if (<int>[404].contains(e.response?.statusCode)) {
        throw WrongCredentionalException();
      } else if (<int>[500].contains(e.response?.statusCode)) {
        throw ServerException();
      }
    }
  }

  Future<bool> checkAuth() async {
    if (await TokenStorage.getAccessToken() == null) {
      return false;
    }

    var user = await _api.getCurrentUser();

    if (user != null) {
      // var token = await FirebaseMessaging.instance.getToken();
      // if (token != null) await _api.subscribe(PushToken(token: token));
      await SharedPrefs.setStoredUser(user);
      await _dataService.createUpdateUser(user);
    }

    return true;
  }

  Future registerUser({
    required String nickName,
    required String email,
    required String password,
    required String retryPassword,
    required DateTime birthDate,
    required String phoneNumber,
    required String givenName,
    String? surname,
    required String country,
    required String gender,
  }) async {
    final model = Registration(
        nickName: nickName,
        email: email,
        password: password,
        retryPassword: retryPassword,
        birthDate: birthDate,
        phoneNumber: phoneNumber,
        givenName: givenName,
        surname: surname,
        country: country,
        gender: gender);

    try {
      return await _api.registerUser(model);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw NoNetworkException();
      } else if (<int>[500, 400].contains(e.response?.statusCode)) {
        throw ServerException();
      }
    }
  }

  Future cleanToken() async {
    await TokenStorage.setStoredToken(null);
  }

  Future logout() async {
    try {
      await _api.unsubscribe();
    } on Exception catch (e, _) {
      e.toString().console();
    }
    await cleanToken();
  }
}
