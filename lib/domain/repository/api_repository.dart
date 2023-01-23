import 'dart:io';

import 'package:photogram_app/domain/models/post_create_model.dart';
import 'package:photogram_app/domain/models/push_token.dart';
import 'package:photogram_app/domain/models/user_short.dart';

import '../models/attach_meta.dart';
import '../models/registration.dart';
import '../models/token_response.dart';
import '../models/user.dart';
import '../models/post_model.dart';

abstract class ApiRepository {
  Future<TokenResponse?> getToken(
      {required String login, required String password});
  Future<TokenResponse?> refreshToken(String refreshToken);
  Future registerUser(Registration model);

  Future<User?> getCurrentUser();
  Future<List<PostModel>> getFeed(int skip, int take);
  Future<List<AttachMeta>> uploadTemp({required List<File> files});
  Future addAvatarToUser(AttachMeta model);
  Future<String> createPost(PostCreateModel request);
  Future subscribe(PushToken model);
  Future unsubscribe();
  Future<List<UserShort>> getUsers();
  Future<List<PostModel>> getAllPosts(int skip, int take);
  Future<PostModel> getPost(String id);
  Future<List<PostModel>> getCurrentUserPosts(int skip, int take);
  Future<UserShort> deleteCurrentUser();
  Future<List<UserShort>> getCurrentUserFollowings();
  Future<List<UserShort>> getCurrentUserFollowers();
}
