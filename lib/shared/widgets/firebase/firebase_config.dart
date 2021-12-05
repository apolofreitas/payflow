import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (kIsWeb) {
      return const FirebaseOptions(
        apiKey: 'AIzaSyAtNGQzQIDNYi7vc5lYnlgjPTGwMBsSQNo',
        authDomain: 'payflow-f3adf.firebaseapp.com',
        projectId: 'payflow-f3adf',
        storageBucket: 'payflow-f3adf.appspot.com',
        messagingSenderId: '10872801586',
        appId: '1:10872801586:web:5b90f17b0d926982bb2f2b',
        measurementId: 'G-4QK6SL3BGB',
      );
    }

    if (Platform.isAndroid) {
      return const FirebaseOptions(
        apiKey: 'AIzaSyCivrZlUDQBXfYjJOpyahJqvbJsMI-MOrA',
        appId: '1:10872801586:android:c1a1de6c1318c3b7bb2f2b',
        messagingSenderId: '10872801586',
        projectId: 'payflow-f3adf',
        storageBucket: 'payflow-f3adf.appspot.com',
        authDomain: 'payflow-f3adf.firebaseapp.com',
        androidClientId:
            '10872801586-o143nrd9fls7qijhki8h9bvqm2c82dnp.apps.googleusercontent.com',
      );
    }

    throw "Plataform is not supported.";
  }
}
