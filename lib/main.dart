import 'package:flutter/material.dart';
import 'package:payflow/modules/splash/splash_page.dart';
import 'package:payflow/shared/app/app_provider.dart';

import 'shared/app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await App.beforeRunApp();
  runApp(
    const AppProvider(
      child: App(),
      fallback: MaterialApp(home: SplashPage()),
    ),
  );
}
