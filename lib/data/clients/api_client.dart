import 'dart:io';

import 'package:photogram_app/domain/models/attach_meta.dart';
import 'package:photogram_app/domain/models/post_create_model.dart';
import 'package:photogram_app/domain/models/post_model.dart';
import 'package:photogram_app/domain/models/push_token.dart';
import 'package:photogram_app/domain/models/user_short.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/models/user.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST("/api/Attach/UploadFiles")
  Future<List<AttachMeta>> uploadTemp(
      {@Part(name: "files") required List<File> files});

  @GET("/api/User/GetCurrentUser")
  Future<User?> getCurrentUser();

  @GET("/api/User/GetUsers")
  Future<List<UserShort>> getUsers();

  @DELETE("/api/User/Delete")
  Future<UserShort> deleteCurrentUser();

  @POST("/api/User/AddAvatarToUser")
  Future addAvatarToUser(@Body() AttachMeta model);

  @GET("/api/User/GetCurrentUserFollowings")
  Future<List<UserShort>> getCurrentUserFollowings();

  @GET("/api/User/GetCurrentUserFollowers")
  Future<List<UserShort>> getCurrentUserFollowers();

  @GET("/api/Post/GetFeed")
  Future<List<PostModel>> getFeed(
      @Query("skip") int skip, @Query("take") int take);

  @POST("/api/Post/CreatePost")
  Future<String> createPost(@Body() PostCreateModel request);

  @GET("/api/Post/GetAllPosts")
  Future<List<PostModel>> getAllPosts(
      @Query("skip") int skip, @Query("take") int take);

  @GET("/api/Post/GetPost")
  Future<PostModel> getPost(@Query("id") String id);

  @GET("/api/Post/GetCurrentUserPosts")
  Future<List<PostModel>> getCurrentUserPosts(
      @Query("skip") int skip, @Query("take") int take);

  @POST("/api/Push/Subscribe")
  Future subscribe(@Body() PushToken model);

  @DELETE("/api/Push/Unsubscribe")
  Future unsubscribe();
}
