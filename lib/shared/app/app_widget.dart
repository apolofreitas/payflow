import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:payflow/modules/insert_boleto/insert_boleto_page.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_theme.dart';
import 'package:payflow/modules/home/home_page.dart';
import 'package:payflow/modules/login/login_page.dart';
import 'package:payflow/modules/splash/splash_page.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static Future<void> beforeRunApp() async {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
      ),
    );
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void onInit() async {
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
  }

  @override
  Widget build(BuildContext context) {
    onInit();

    return GetMaterialApp(
      title: 'PayFlow',
      themeMode: ThemeMode.light,
      theme: AppTheme.theme,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/barcode_scanner': (context) => const BarcodeScannePage(),
        '/insert_boleto': (context) => const InsertBoleto(),
      },
    );
  }
}
