// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map_proj/provider/user_provider.dart';
import 'package:provider/provider.dart';

import 'landing.dart';
// import 'package:map_proj/model/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var provider = context.read<UserProvider>();

    signOut() async {
      await auth.signOut();
      provider.logout();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LandingScreen()));
    }

    Widget logoutButton() {
      if (provider.user.role != 'Guest') {
        return MaterialButton(
          color: Colors.blue,
          onPressed: () async {
            await signOut();
          },
          child: const Icon(Icons.logout),
        );
      }
      return Container();
    }

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Profile Page'),
          Text('Role: ${provider.user.role}'),
          logoutButton(),
          // Text('${widget.userModel.email}'),
          // Text('${widget.userModel.fullName}'),
          // Text('${widget.userModel.gender}'),
          // Text('${widget.userModel.ic}'),
          // Text('${widget.userModel.region}'),
          // Text('${widget.userModel.states}'),
          // Text('${widget.userModel.uid}'),
        ],
      ),
    );
  }
}