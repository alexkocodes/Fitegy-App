import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCpIJ7llnpUjfNfTFv6T-RqasSdgTY7eFg",
            authDomain: "fitegy-8c775.firebaseapp.com",
            projectId: "fitegy-8c775",
            storageBucket: "fitegy-8c775.appspot.com",
            messagingSenderId: "822428050129",
            appId: "1:822428050129:web:a6049b192402ccf3515bf0",
            measurementId: "G-3LQD19NFVX"));
  } else {
    await Firebase.initializeApp();
  }
}
