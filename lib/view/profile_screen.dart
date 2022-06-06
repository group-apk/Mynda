import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynda/provider/user_provider.dart';
import 'package:mynda/view/landing.dart';
import 'package:provider/provider.dart';

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
    final navigator = Navigator.of(context);

    signOut() async {
      await auth.signOut();
      provider.logout();

      navigator.pushReplacement(
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

    Widget body = SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Profile Page'),
          Text('Role: ${provider.user.role}'),
          logoutButton(),
        ],
      ),
    );

    if (provider.user.role != 'Guest') {
      return WillPopScope(onWillPop: (() async => false), child: body);
    }
    return body;
  }
}
