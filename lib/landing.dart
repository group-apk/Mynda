import 'package:flutter/material.dart';
import 'package:map_proj/dashboard.dart';
import 'package:map_proj/main.dart';
import 'package:map_proj/screen/login_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.help,
                      size: 200,
                    ),
                    Text(
                      'Mynda',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 50),
                    ),
                  ],
                ),
                flex: 3,
              ),
              Expanded(
                  child: Column(
                children: [
                  MaterialButton(
                    child: const Text(
                      'Enter',
                      style: TextStyle(fontSize: 30),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DashboardScreen()));
                    },
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
    );
  }
}
