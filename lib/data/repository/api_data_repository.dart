import 'dart:io';

import 'package:photogram_app/data/clients/api_client.dart';
import 'package:photogram_app/data/clients/auth_client.dart';
import 'package:photogram_app/domain/models/post_create_model.dart';
import 'package:photogram_app/domain/models/post_model.dart';
import 'package:photogram_app/domain/models/push_token.dart';
import 'package:photogram_app/domain/models/refresh_token_request.dart';
import 'package:photogram_app/domain/models/registration.dart';
import 'package:photogram_app/domain/models/token_request.dart';
import 'package:photogram_app/domain/models/token_response.dart';
import 'package:photogram_app/domain/models/user.dart';
import 'package:photogram_app/domain/models/user_short.dart';
import 'package:photogram_app/domain/repository/api_repository.dart';

import '../../domain/models/attach_meta.dart';

class ApiDataRepository extends ApiRepository {
  final AuthClient _auth;
  final ApiClient _api;
  ApiDataRepository(this._auth, this._api);

  @override
  Future<TokenResponse?> getToken({
    required String login,
    required String password,
  }) async {
    return await _auth.getToken(TokenRequest(
      login: login,
      pass: password,
    ));
  }

  @override
  Future<TokenResponse?> refreshToken(String refreshToken) async =>
      await _auth.refreshToken(RefreshTokenRequest(
        refreshToken: refreshToken,
      ));

  @override
  Future<User?> getCurrentUser() => _api.getCurrentUser();

  @override
  Future<List<PostModel>> getFeed(int skip, int take) =>
      _api.getFeed(skip, take);

  @override
  Future<List<AttachMeta>> uploadTemp({required List<File> files}) =>
      _api.uploadTemp(files: files);

  @override
  Future addAvatarToUser(AttachMeta model) => _api.addAvatarToUser(model);

  @override
  Future<String> createPost(PostCreateModel request) =>
      _api.createPost(request);

  @override
  Future registerUser(Registration model) => _auth.registerUser(model);

  @override
  Future subscribe(PushToken model) => _api.subscribe(model);

  @override
  Future unsubscribe() => _api.unsubscribe();

  @override
  Future<List<PostModel>> getAllPosts(int skip, int take) =>
      _api.getAllPosts(skip, take);

  @override
  Future<List<UserShort>> getUsers() => _api.getUsers();

  @override
  Future<PostModel> getPost(String id) => _api.getPost(id);

  @override
  Future<List<PostModel>> getCurrentUserPosts(int skip, int take) =>
      _api.getCurrentUserPosts(skip, take);

  @override
  Future<UserShort> deleteCurrentUser() => _api.deleteCurrentUser();

  @override
  Future<List<UserShort>> getCurrentUserFollowings() =>
      _api.getCurrentUserFollowings();

  @override
  Future<List<UserShort>> getCurrentUserFollowers() =>
      _api.getCurrentUserFollowers();
}
