import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:payflow/modules/insert_boleto/insert_boleto_page.dart';
import 'package:payflow/shared/services/database.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_theme.dart';
import 'package:payflow/modules/home/home_page.dart';
import 'package:payflow/modules/login/login_page.dart';
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

    await DatabaseService.initialize();
  }

  void _onUserStateChange(User? user) {
    if (Get.key.currentState == null) return;

    if (user == null) {
      if (Get.currentRoute != '/login') {
        Get.offNamed("/login");
      }
    } else {
      if (Get.currentRoute == '/splash' || Get.currentRoute == '/login') {
        Get.offNamed("/home");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();

    _onUserStateChange(user);

    return GetMaterialApp(
      title: 'PayFlow',
      themeMode: ThemeMode.light,
      theme: AppTheme.theme,
      initialRoute: user == null ? '/login' : '/home',
      getPages: [
        GetPage(
          name: '/login',
          page: () => const LoginPage(),
        ),
        GetPage(
          name: '/home',
          page: () => const HomePage(),
        ),
        GetPage(
          name: '/barcode_scanner',
          page: () => const BarcodeScannePage(),
        ),
        GetPage(
          name: '/insert_boleto',
          page: () => InsertBoleto(
            barcode: Get.arguments?['barcode'],
          ),
        ),
      ],
    );
  }
}
