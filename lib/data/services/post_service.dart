import 'package:photogram_app/domain/models/post_create_model.dart';
import 'package:photogram_app/domain/models/post_model.dart';

import '../../domain/models/attach_meta.dart';
import '../../domain/repository/api_repository.dart';
import '../../internal/dependencies/repository_module.dart';

class PostService {
  final ApiRepository _api = RepositoryModule.apiRepository();

  Future<String?> createPost(
      String authorId, String? text, List<AttachMeta> contents) async {
    if (contents.isEmpty) return null;
    final request =
        PostCreateModel(authorId: authorId, text: text, contents: contents);
    return await _api.createPost(request);
  }

  Future<List<PostModel>> getFeed(int skip, int take) async {
    return await _api.getFeed(skip, take);
  }

  Future<List<PostModel>> getAllPosts(int skip, int take) async {
    return await _api.getAllPosts(skip, take);
  }

  Future<PostModel> getPost(String id) async {
    return await _api.getPost(id);
  }

  Future<List<PostModel>> getCurrentUserPosts(int skip, int take) async {
    return await _api.getCurrentUserPosts(skip, take);
  }
}
