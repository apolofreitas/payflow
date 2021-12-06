import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/app/app_widget.dart';

class FirebaseWidget extends StatefulWidget {
  final Widget onLoading;
  final Widget onError;
  final Widget child;

  const FirebaseWidget({
    Key? key,
    required this.onLoading,
    required this.onError,
    required this.child,
  }) : super(key: key);

  @override
  _FirebaseWidgetState createState() => _FirebaseWidgetState();
}

class _FirebaseWidgetState extends State<FirebaseWidget> {
  bool _isLoading = true;
  bool _hasError = false;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      setState(() {
        _hasError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return widget.onLoading;
    if (_hasError) return widget.onError;
    return widget.child;
  }
}
