import 'package:photogram_app/data/services/auth_service.dart';
import 'package:photogram_app/internal/config/theme_config.dart';
import 'package:photogram_app/internal/utils.dart';
import 'package:photogram_app/ui/navigation/app_navigator.dart';
import 'package:photogram_app/ui/widgets/interface_elements/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../interface_elements/brand.dart';
import '../interface_elements/fitted_text.dart';

class _AuthViewModelState {
  final String? login;
  final String? password;
  final bool isLoading;
  final String? errorText;
  const _AuthViewModelState({
    this.login,
    this.password,
    this.isLoading = false,
    this.errorText,
  });

  _AuthViewModelState copyWith({
    String? login,
    String? password,
    bool? isLoading = false,
    String? errorText,
  }) {
    return _AuthViewModelState(
      login: login ?? this.login,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorText: errorText ?? this.errorText,
    );
  }
}

class _AuthViewModel extends ChangeNotifier {
  var loginTec = TextEditingController();
  var passwTec = TextEditingController();
  final _authService = AuthService();

  BuildContext context;
  _AuthViewModel({required this.context}) {
    loginTec.addListener(() {
      state = state.copyWith(login: loginTec.text);
    });
    passwTec.addListener(() {
      state = state.copyWith(password: passwTec.text);
    });
  }

  var _state = const _AuthViewModelState();
  _AuthViewModelState get state => _state;
  set state(_AuthViewModelState val) {
    _state = val;
    notifyListeners();
  }

  bool checkFields() {
    return (state.login?.isNotEmpty ?? false) &&
        (state.password?.isNotEmpty ?? false);
  }

  Future login() async {
    state = state.copyWith(isLoading: true);

    try {
      await _authService.auth(state.login, state.password).then((value) {
        AppNavigator.toLoader()
            .then((value) => {state = state.copyWith(isLoading: false)});
      });
    } on NoNetworkException {
      state = state.copyWith(errorText: "No network");
    } on WrongCredentionalException {
      state = state.copyWith(errorText: "Incorrect login or password");
    } on ServerException {
      state = state.copyWith(errorText: "An error occurred on the server");
    }
  }

  void Function()? tryLogin(BuildContext context) {
    if (checkFields()) {
      return () async {
        await login();
        var errorText = state.errorText;
        if (errorText != null) {
          showToast(
              context: context, toastType: ToastsEnum.error, text: errorText);
        }
      };
    }
    return null;
  }
}

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(snowStatusBar); //!!!!
    var viewModel = context.watch<_AuthViewModel>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                  height: 4,
                  child: viewModel.state.isLoading
                      ? LinearProgressIndicator(
                          backgroundColor: Theme.of(context).canvasColor,
                        )
                      : null),
              Expanded(
                  flex: 9,
                  child: FractionallySizedBox(
                      alignment: Alignment.bottomCenter,
                      heightFactor: 0.9,
                      widthFactor: 1,
                      child: SvgPicture.asset(
                        "assets/photogram.svg",
                      ))),
              const Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    heightFactor: 0.8,
                    alignment: Alignment.topCenter,
                    child: Brand(),
                  ),
                  flex: 4),
              Expanded(
                  child: FractionallySizedBox(
                      widthFactor: 0.9,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: viewModel.loginTec,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter login",
                            labelText: "Login"),
                      )),
                  flex: 3),
              const SizedBox(height: 10),
              Expanded(
                  child: FractionallySizedBox(
                      widthFactor: 0.9,
                      child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: viewModel.passwTec,
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter password",
                              labelText: "Password"))),
                  flex: 3),
              const SizedBox(height: 5),
              Flexible(
                  //child: Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30)),
                      onPressed: viewModel.tryLogin(context),
                      child: FittedText(
                        "Login",
                      )),
                  flex: 3),
              Flexible(
                  flex: 3,
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(child: FittedText("Not registered yet?")),
                          Flexible(
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          shape: const StadiumBorder()),
                                      onPressed: AppNavigator.toRegistration,
                                      child: FittedText(
                                        "Registration",
                                      )))),
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }

  static Widget create() => ChangeNotifierProvider<_AuthViewModel>(
        create: (context) => _AuthViewModel(context: context),
        child: const Auth(),
      );
}
