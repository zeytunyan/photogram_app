import 'package:photogram_app/data/services/auth_service.dart';
import 'package:photogram_app/internal/config/theme_config.dart';
import 'package:photogram_app/ui/navigation/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class _LoaderViewModel extends ChangeNotifier {
  final _authService = AuthService();

  BuildContext context;

  _LoaderViewModel({required this.context}) {
    _asyncInit();
  }

  void _asyncInit() async {
    if (await _authService.checkAuth()) {
      AppNavigator.toHome();
    } else {
      AppNavigator.toAuth();
    }
  }
}

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(snowStatusBar); //!!!!
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  static Widget create() => ChangeNotifierProvider<_LoaderViewModel>(
        create: (context) => _LoaderViewModel(context: context),
        child: const LoaderWidget(),
        lazy: false,
      );
}
