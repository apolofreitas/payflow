import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payflow/modules/home/home_page.dart';
import 'package:payflow/modules/login/login_page.dart';
import 'package:payflow/modules/splash/splash_page.dart';
import 'package:payflow/shared/themes/app_theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (Get.currentRoute == '/splash') {
        await Future.delayed(const Duration(seconds: 2));
      }

      if (user == null) {
        if (Get.currentRoute != '/login') {
          Get.offNamed("/login");
        }
      } else {
        if (Get.currentRoute == '/splash' || Get.currentRoute == '/login') {
          Get.offNamed("/home");
        }
      }
    });

    return GetMaterialApp(
      title: 'PayFlow',
      theme: AppTheme.theme,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
