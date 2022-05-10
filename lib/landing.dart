import 'package:flutter/material.dart';
import 'package:map_proj/main.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              child: Center(
                child: Text(
                  'Mynda',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 50),
                ),
              ),
              flex: 3,
            ),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    MaterialButton(
                      child: const Text(
                        'Enter',
                        style: TextStyle(fontSize: 30),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const DashboardScreen()));
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
    );
  }
}
