import 'package:photogram_app/data/services/database.dart';
import 'package:photogram_app/domain/db_model.dart';
import 'package:photogram_app/domain/models/post.dart';
import 'package:photogram_app/domain/models/post_content.dart';
import 'package:photogram_app/domain/models/post_model.dart';
import 'package:photogram_app/domain/models/user.dart';
import 'package:photogram_app/domain/models/user_short.dart';

class DataService {
  Future createUpdateUser(User user) async {
    await DB.instance.createUpdate(user);
  }

  Future rangeUpdateEntities<T extends DbModel>(Iterable<T> elems) async {
    await DB.instance.createUpdateRange(elems);
  }

  Future<List<PostModel>> getPosts() async {
    var res = <PostModel>[];
    var posts = await DB.instance.getAll<Post>();
    for (var post in posts) {
      var author = await DB.instance.get<UserShort>(post.authorId);

      var contents =
          (await DB.instance.getAll<PostContent>(whereMap: {"postId": post.id}))
              .toList();

      if (author != null) {
        res.add(PostModel(
          id: post.id,
          text: post.text,
          created: post.created,
          changed: post.changed,
          repostedId: post.repostedId,
          repostsCount: post.repostsCount,
          commentsCount: post.commentsCount,
          likesCount: post.likesCount,
          author: author,
          contents: contents,
        ));
      }
    }

    return res;
  }
}
