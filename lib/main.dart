import 'package:photogram_app/internal/config/theme_config.dart';
import 'package:photogram_app/ui/navigation/app_navigator.dart';
import 'package:photogram_app/ui/widgets/screens/loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_preview/device_preview.dart';

import 'internal/init_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initApp();

// Только для Android?
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const Photogram(), // Wrap your app
    ),
  );
}

class Photogram extends StatelessWidget {
  const Photogram({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Photogram',
      debugShowCheckedModeBanner: false,
      navigatorKey: AppNavigator.key,
      onGenerateRoute: (settings) =>
          AppNavigator.onGeneratedRoutes(settings, context),
      theme: ThemeData(
          fontFamily: mainFont(fontWeight: FontWeight.w600).fontFamily,
          primarySwatch: primarySwatch,
          canvasColor: canvasColor),
      home: LoaderWidget.create(),
    );
  }
}
