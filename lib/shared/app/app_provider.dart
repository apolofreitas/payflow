import 'package:flutter/material.dart';
import 'package:payflow/shared/widgets/firebase/firebase_widget.dart';

class AppProvider extends StatelessWidget {
  final Widget child;

  const AppProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirebaseWidget(
      onLoading: Container(),
      onError: Container(),
      child: child,
    );
  }
}
