import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../main.dart';
// ignore_for_file: prefer_const_constructors
// ignore_for_file: avoid_print

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  //signout function
  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyApp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text("Mynda"),
      ),

      //  floating Action Button using for signout ,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await auth.signOut();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyApp()));
        },
        child: Icon(Icons.logout_rounded),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text("Home page"),
      ),
    );
  }
}
