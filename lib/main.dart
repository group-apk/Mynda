import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:map_proj/landing.dart';
import 'package:map_proj/new_notifier/test_notifier.dart';
// import 'package:map_proj/notifier/question_notifier.dart';
import 'package:provider/provider.dart';
// ignore_for_file: prefer_const_constructors

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => TestNotifier(),
        child: const MyApp()),
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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//Initialize Firebase App
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return LandingScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
