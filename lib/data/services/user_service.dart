import 'package:photogram_app/domain/models/user_short.dart';

import '../../domain/repository/api_repository.dart';
import '../../internal/dependencies/repository_module.dart';

class UserService {
  final ApiRepository _api = RepositoryModule.apiRepository();

  Future<List<UserShort>> getUsers() async {
    return await _api.getUsers();
  }

  Future<UserShort> deleteCurrentUser() async {
    return await _api.deleteCurrentUser();
  }

  Future<List<UserShort>> getCurrentUserFollowings() async {
    return await _api.getCurrentUserFollowings();
  }

  Future<List<UserShort>> getCurrentUserFollowers() async {
    return await _api.getCurrentUserFollowers();
  }
}
