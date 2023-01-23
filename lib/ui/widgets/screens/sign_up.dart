import 'package:photogram_app/data/services/auth_service.dart';
import 'package:photogram_app/internal/config/theme_config.dart';
import 'package:photogram_app/internal/utils.dart';
import 'package:photogram_app/ui/navigation/app_navigator.dart';
import 'package:photogram_app/ui/widgets/interface_elements/fitted_text.dart';
import 'package:photogram_app/ui/widgets/interface_elements/toast.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class _SignUpViewModelState {
  final String? nickName;
  final String? email;
  final String? password;
  final String? retryPassword;
  final DateTime? birthDate;
  final String? phoneNumber;
  final String? givenName;
  final String? surname;
  final String? country;
  final String? gender;
  final bool isLoading;
  final String? errorText;

  const _SignUpViewModelState({
    this.nickName,
    this.email,
    this.password,
    this.retryPassword,
    this.birthDate,
    this.phoneNumber,
    this.givenName,
    this.surname,
    this.country,
    this.gender,
    this.isLoading = false,
    this.errorText,
  });

  _SignUpViewModelState copyWith({
    String? nickName,
    String? email,
    String? password,
    String? retryPassword,
    DateTime? birthDate,
    String? phoneNumber,
    String? givenName,
    String? surname,
    String? country,
    String? gender,
    bool? isLoading = false,
    String? errorText,
  }) {
    return _SignUpViewModelState(
      nickName: nickName ?? this.nickName,
      email: email ?? this.email,
      password: password ?? this.password,
      retryPassword: retryPassword ?? this.retryPassword,
      birthDate: birthDate ?? this.birthDate,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      givenName: givenName ?? this.givenName,
      surname: surname ?? this.surname,
      country: country ?? this.country,
      gender: gender ?? this.gender,
      isLoading: isLoading ?? this.isLoading,
      errorText: errorText ?? this.errorText,
    );
  }
}

class _SignUpViewModel extends ChangeNotifier {
  final genders = ["Man", "Woman", "Another"];
  DateTime birthDate = DateTime.now();

  var nickNameTec = TextEditingController();
  var emailTec = TextEditingController();
  var passwTec = TextEditingController();
  var retryPasswTec = TextEditingController();
  var birthDateTec = TextEditingController();
  var phoneNumberTec = TextEditingController();
  var givenNameTec = TextEditingController();
  var surnameTec = TextEditingController();
  var countryTec = TextEditingController();

  final _auth = AuthService();
  BuildContext context;

  _SignUpViewModel({required this.context}) {
    nickNameTec.addListener(() {
      state = state.copyWith(nickName: nickNameTec.text);
    });

    emailTec.addListener(() {
      state = state.copyWith(email: emailTec.text);
    });

    passwTec.addListener(() {
      state = state.copyWith(password: passwTec.text);
    });

    retryPasswTec.addListener(() {
      state = state.copyWith(retryPassword: retryPasswTec.text);
    });

    birthDateTec.addListener(() {
      state = state.copyWith(birthDate: birthDate);
    });

    phoneNumberTec.addListener(() {
      state = state.copyWith(phoneNumber: phoneNumberTec.text);
    });

    givenNameTec.addListener(() {
      state = state.copyWith(givenName: givenNameTec.text);
    });

    surnameTec.addListener(() {
      state = state.copyWith(surname: surnameTec.text);
    });

    countryTec.addListener(() {
      state = state.copyWith(country: countryTec.text);
    });
  }

  var _state = const _SignUpViewModelState();
  _SignUpViewModelState get state => _state;
  set state(_SignUpViewModelState val) {
    _state = val;
    notifyListeners();
  }

  bool checkFields() {
    return (state.nickName?.isNotEmpty ?? false) &&
        (state.email?.isNotEmpty ?? false) &&
        (state.password?.isNotEmpty ?? false) &&
        (state.retryPassword?.isNotEmpty ?? false) &&
        (state.birthDate != null) &&
        (state.phoneNumber?.isNotEmpty ?? false) &&
        (state.givenName?.isNotEmpty ?? false) &&
        (state.country?.isNotEmpty ?? false) &&
        (state.gender?.isNotEmpty ?? false);
  }

  Future signUp() async {
    state = state.copyWith(isLoading: true);

    try {
      await _auth
          .registerUser(
              nickName: state.nickName!,
              email: state.email!,
              password: state.password!,
              retryPassword: state.retryPassword!,
              birthDate: state.birthDate!,
              phoneNumber: state.phoneNumber!,
              givenName: state.givenName!,
              surname: state.surname,
              country: state.country!,
              gender: state.gender!)
          .then((value) {
        AppNavigator.toAuth()
            .then((value) => {state = state.copyWith(isLoading: false)});
      });
    } on NoNetworkException {
      state = state.copyWith(errorText: "No network");
    } on ServerException {
      state = state.copyWith(errorText: "An error occurred on the server");
    }
  }

  void Function()? trySignUp(BuildContext context) {
    if (checkFields()) {
      return () async {
        await signUp();
        var errorText = state.errorText;
        if (errorText != null) {
          showToast(
              context: context, toastType: ToastsEnum.error, text: errorText);
        } else {
          showToast(
              context: context,
              toastType: ToastsEnum.success,
              text: "Success!");
        }
      };
    }
    return null;
  }

  Future pickDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: birthDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    birthDate = date ?? birthDate;
    final formattedDate = DateFormat('dd.MM.yyyy').format(birthDate);
    birthDateTec.text = formattedDate;
  }
}

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(royalBlueStatusBar); //!!!!

    var viewModel = context.watch<_SignUpViewModel>();

    final fields = [
      TextFormField(
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        controller: viewModel.nickNameTec,
        decoration: const InputDecoration(
            icon: Icon(Icons.abc),
            border: OutlineInputBorder(),
            hintText: "Enter your nickname",
            labelText: "Nickname*",
            helperText: "Come up with a nickname"),
      ),
      TextFormField(
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        controller: viewModel.emailTec,
        decoration: const InputDecoration(
            icon: Icon(Icons.email),
            border: OutlineInputBorder(),
            hintText: "Enter your email",
            labelText: "Email*",
            helperText: "Your e-mail address is used as a login"),
      ),
      TextFormField(
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          controller: viewModel.passwTec,
          obscureText: true,
          decoration: const InputDecoration(
              icon: Icon(Icons.password),
              border: OutlineInputBorder(),
              hintText: "Enter password",
              labelText: "Password*",
              helperText: "8 characters, one digit and uppercase letter")),
      TextFormField(
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          controller: viewModel.retryPasswTec,
          obscureText: true,
          decoration: const InputDecoration(
              icon: Icon(Icons.password_outlined),
              border: OutlineInputBorder(),
              hintText: "Enter password again",
              labelText: "Retry password*",
              helperText: "Repeat the password to remember it")),
      TextFormField(
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        controller: viewModel.givenNameTec,
        decoration: const InputDecoration(
            icon: Icon(Icons.person),
            border: OutlineInputBorder(),
            hintText: "Enter your given name",
            labelText: "Given name*",
            helperText: "Given name displayed on your page"),
      ),
      TextFormField(
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        controller: viewModel.surnameTec,
        decoration: const InputDecoration(
            icon: Icon(Icons.person_outline),
            border: OutlineInputBorder(),
            hintText: "Enter your surname",
            labelText: "Surname",
            helperText: "Surname displayed on your page (optional)"),
      ),
      TextFormField(
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        controller: viewModel.phoneNumberTec,
        decoration: const InputDecoration(
            icon: Icon(Icons.phone),
            border: OutlineInputBorder(),
            hintText: "Enter your phone number",
            labelText: "Phone number*",
            helperText: "Phone number is used to access to the account"),
      ),
      TextFormField(
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        controller: viewModel.countryTec,
        decoration: const InputDecoration(
            icon: Icon(Icons.public),
            border: OutlineInputBorder(),
            hintText: "Enter your country",
            labelText: "Country*",
            helperText: "The country you are from"),
      ),
      DropdownButtonFormField<String>(
        decoration: const InputDecoration(
            icon: Icon(Icons.transgender),
            border: OutlineInputBorder(),
            hintText: "Choose your gender",
            labelText: "Gender*",
            helperText: "Your gender"),
        items: viewModel.genders
            .map((gender) =>
                DropdownMenuItem<String>(value: gender, child: Text(gender)))
            .toList(),
        onChanged: (String? value) {
          viewModel.state = viewModel.state.copyWith(gender: value);
        },
      ),
      const SizedBox(width: 15),
      TextFormField(
        readOnly: true,
        controller: viewModel.birthDateTec,
        decoration: const InputDecoration(
            icon: Icon(Icons.cake),
            suffixIcon: Icon(Icons.edit_calendar),
            border: OutlineInputBorder(),
            hintText: "Choose",
            labelText: "Birth date*",
            helperText: "Your birth date"),
        onTap: () async {
          await viewModel.pickDate(context);
        },
      ),
      const Divider(),
      Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
              onPressed: viewModel.trySignUp(context),
              child: FittedText(
                "Register",
              ))),
    ];

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: FractionallySizedBox(
                  widthFactor: 0.5,
                  child: FittedText(
                    "Registration",
                    style: logoFont(),
                  ),
                )),
            body: SafeArea(
                child: Column(children: [
              Container(
                  height: 5,
                  alignment: Alignment.bottomCenter,
                  child: viewModel.state.isLoading
                      ? LinearProgressIndicator(
                          minHeight: 4,
                          backgroundColor: Theme.of(context).canvasColor,
                        )
                      : null),
              Expanded(
                  child: ListView.separated(
                padding: const EdgeInsets.all(20.0),
                itemCount: fields.length,
                itemBuilder: (BuildContext context, int index) => fields[index],
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: index == fields.length - 4 ? 0 : 25,
                ),
              ))
            ]))));
  }

  static Widget create() => ChangeNotifierProvider<_SignUpViewModel>(
        create: (context) => _SignUpViewModel(context: context),
        child: const SignUp(),
      );
}
