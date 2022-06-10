import 'package:flutter/material.dart';
import 'package:mobile_ui/src/screens/id_screen.dart';
//import 'package:mobile_ui/src/screens/home_screen.dart';
import 'package:mobile_ui/src/screens/user_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const IdentificationScreen(),
    );
  }
}
