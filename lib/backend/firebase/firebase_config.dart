import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyC0WuIOgIh__mVz3IZ22kMCT6vcfG-qCgc",
            authDomain: "projeto3-lr5vjl.firebaseapp.com",
            projectId: "projeto3-lr5vjl",
            storageBucket: "projeto3-lr5vjl.firebasestorage.app",
            messagingSenderId: "328345213942",
            appId: "1:328345213942:web:33cb083c9265fbc7d485d7"));
  } else {
    await Firebase.initializeApp();
  }
}
