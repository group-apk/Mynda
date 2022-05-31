import 'package:flutter/material.dart';
import 'package:map_proj/landing.dart';
import 'package:map_proj/new_notifier/test_notifier.dart';
// import 'package:map_proj/notifier/question_notifier.dart';
import 'package:map_proj/provider/user_provider.dart';
import 'package:provider/provider.dart';
// ignore_for_file: prefer_const_constructors

void main() {
  runApp(
    // ChangeNotifierProvider(
    //     create: (context) => TestNotifier(),
    //     child: const MyApp()),

    MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (context) => TestNotifier(),
        ),
        ChangeNotifierProvider(
        create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    )
  );
}

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LandingScreen(),
    );
  }
}