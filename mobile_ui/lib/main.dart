import 'package:flutter/material.dart';
import 'package:mobile_ui/firebase_options.dart';
import 'package:mobile_ui/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
