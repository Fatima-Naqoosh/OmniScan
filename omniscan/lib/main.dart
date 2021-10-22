import 'package:flutter/material.dart';
import 'package:omniscan/home_screen.dart';
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';



Future<void> main() async {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}