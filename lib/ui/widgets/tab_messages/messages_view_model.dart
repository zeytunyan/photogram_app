import 'package:photogram_app/data/services/user_service.dart';
import 'package:photogram_app/domain/models/user_short.dart';
import 'package:flutter/material.dart';

class MessagesViewModel extends ChangeNotifier {
  BuildContext context;
  final _userService = UserService();

  List<UserShort>? _users;
  List<UserShort>? get users => _users;
  set users(List<UserShort>? val) {
    _users = val;
    notifyListeners();
  }

  MessagesViewModel({required this.context}) {
    asyncInit();
  }

  void asyncInit() async {
    users = await _userService.getUsers();
  }
}
