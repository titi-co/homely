import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:homely/firebase_options.dart';
import 'package:homely/src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}
