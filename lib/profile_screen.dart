
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screen/registration_screen.dart';
import 'main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

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
        onPressed: () {
          signOut();
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

