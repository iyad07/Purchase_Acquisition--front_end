import 'package:flutter/material.dart';
import 'login.dart';
//import 'user/home.dart';
//import 'admin/home.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


