import 'package:flutter/material.dart';
import 'package:mynda/provider/dashboard_provider.dart';
import 'package:mynda/provider/test_notifier.dart';
import 'package:mynda/provider/user_provider.dart';
import 'package:mynda/view/landing.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => TestNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => DashboardProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LandingScreen(),
    );
  }
}
