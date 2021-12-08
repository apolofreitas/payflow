import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/services/database.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class AppProvider extends StatelessWidget {
  final Widget child;
  final Widget fallback;

  const AppProvider({
    Key? key,
    required this.child,
    required this.fallback,
  }) : super(key: key);

  Future<void> initializeApp() async {
    await Future.wait(
      [
        Future.delayed(const Duration(seconds: 2)),
        DatabaseService.initialize(),
        Future(() async {
          await Firebase.initializeApp();
          await FirebaseAuth.instance.authStateChanges().first;
        })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return fallback;
        }

        return MultiProvider(
          providers: [
            Provider<Database>(create: (_) => DatabaseService.db),
            StreamProvider<User?>(
              initialData: FirebaseAuth.instance.currentUser,
              create: (_) => FirebaseAuth.instance.authStateChanges(),
            ),
          ],
          child: child,
        );
      },
    );
  }
}
