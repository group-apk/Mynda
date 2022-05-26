import 'package:flutter/material.dart';
import 'package:map_proj/new_api/test_api.dart';
import 'package:map_proj/new_notifier/test_notifier.dart';
import 'package:map_proj/new_view/test_category_screen.dart';
import 'package:map_proj/view/dashboard.dart';
import 'package:map_proj/view/dashboard_screen.dart';
import 'package:map_proj/view/login_screen.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    var testProvider = context.read<TestNotifier>();
    getTest(testProvider);
    
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Container(
            color: Colors.white,
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Mynda",
                        style: TextStyle(
                          color: Color.fromARGB(255, 16, 100, 168),
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                          height: 200,
                          child: Image.asset(
                            "assets/landing.png",
                            fit: BoxFit.contain,
                          )),
                    ],
                  ),
                  flex: 3,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 32.0),
                        color: Colors.blue,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: const Text(
                          'Enter',
                          style: TextStyle(fontSize: 30),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DashboardScreen()));
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: const Text(
                        'Sign-in as a User/Staff',
                        style: TextStyle(
                            color: Color(0xFF0069FE),
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
