import 'package:flutter/material.dart';
import 'package:payflow/shared/app/app_provider.dart';

import 'shared/app/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppProvider(child: App()));
}
