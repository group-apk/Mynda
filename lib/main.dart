import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:map_proj/landing.dart';
import 'package:map_proj/provider/user_provider.dart';
import 'package:provider/provider.dart';
// ignore_for_file: prefer_const_constructors

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MaterialApp(
        home: LandingScreen(),
      ),
    );
  }
}
