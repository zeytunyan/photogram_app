// import 'dart:io';
// import 'package:photogram_app/internal/utils.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//import '../firebase_options.dart';
// import '../ui/navigation/app_navigator.dart';
// import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../data/services/database.dart';

// void catchMessage(RemoteMessage message) {
//   "Got a message whilst in the foreground!".console();
//   'Message data: ${message.data}'.console();
//   if (message.notification != null) {
//     showModal(message.notification!.title!, message.notification!.body!);
//     // var post = '';
//     // var ctx = AppNavigator.navigationKeys[TabItemsEnum.home]?.currentContext;
//     // if (ctx != null) {
//     //   var appviewModel = ctx.read<AppViewModel>();
//     //   Navigator.of(ctx)
//     //       .pushNamed(TabNavigatorRoutes.postDetails, arguments: post);
//     //   appviewModel.selectTab(TabItemsEnum.home);
//     // }
//   }
// }

// Future initFireBase() async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   var messaging = FirebaseMessaging.instance;
//   await messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true);
//   FirebaseMessaging.onMessage.listen(catchMessage);
//   FirebaseMessaging.onMessageOpenedApp.listen(catchMessage);
//   try {
//     ((await messaging.getToken()) ?? "no token").console();
//   } catch (e) {
//     e.toString().console();
//   }
// }

Future initApp() async {
  // if (Platform.isAndroid) {
  //   await initFireBase();
  // }

  if (!kIsWeb) {
    await DB.instance.init();
  }
}
