import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynda/provider/dashboard_provider.dart';
import 'package:mynda/view/dashboard.dart';
import 'package:mynda/view/login_screen.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    final dashboard = context.read<DashboardProvider>();
    Widget landingContent = Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Container(
            color: Colors.white,
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
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
                          dashboard.setIndex = 0;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DashboardMain()));
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

    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return landingContent;
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
