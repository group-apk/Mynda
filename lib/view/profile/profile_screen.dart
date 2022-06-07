import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynda/model/user_model.dart';
import 'package:mynda/provider/user_provider.dart';
import 'package:mynda/view/landing.dart';
import 'package:mynda/view/login_screen.dart';
import 'package:mynda/view/profile/edit_profile_screen.dart';
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
    var user = context.read<UserProvider>();
    final navigator = Navigator.of(context);

    signOut() async {
      await auth.signOut();
      user.logout();

      navigator.pushReplacement(
          MaterialPageRoute(builder: (context) => const LandingScreen()));
    }

    Widget logoutButton() {
      if (user.user.role != 'Guest') {
        return Center(
          child: MaterialButton(
            color: Colors.blue,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            onPressed: () async {
              await signOut();
            },
            child: const Text('LOGOUT'),
          ),
        );
      }

      return Center(
        child: MaterialButton(
          color: Colors.blue,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ));
          },
          child: const Text('LOGIN'),
        ),
      );
    }

    Widget updateButton() {
      if (user.user.role != 'Guest') {
        return Center(
          child: MaterialButton(
            color: Colors.blue,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            onPressed: () {
              user.setTemp = user.user;
              navigator.push(
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            },
            child: const Text('UPDATE'),
          ),
        );
      }
      return Container();
    }

    Widget textTile({required String attribute, required String value}) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: Text(attribute)),
          Expanded(
            child: Text(value),
          ),
        ],
      );
    }

    Widget body = SafeArea(
      child: Card(
        elevation: 10,
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'Profile Page',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 30),
                            child: Card(
                              shape: CircleBorder(),
                              elevation: 3,
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Icon(
                                  Icons.person,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: (user.user.role != 'Guest')
                                ? Consumer<UserProvider>(
                                    builder: (context, value, child) => Column(
                                      children: [
                                        textTile(
                                            attribute: 'Full Name:',
                                            value: '${user.user.fullName}'),
                                        textTile(
                                            attribute: 'IC:',
                                            value: '${user.user.ic}'),
                                        textTile(
                                            attribute: 'Gender:',
                                            value: '${user.user.gender}'),
                                        textTile(
                                            attribute: 'Role:',
                                            value: '${user.user.role}'),
                                        textTile(
                                            attribute: 'Email:',
                                            value: '${user.user.email}'),
                                        (user.user.role == 'member')
                                            ? Container()
                                            : textTile(
                                                attribute: 'Academic:',
                                                value: '${user.user.academic}'),
                                        textTile(
                                            attribute: 'Region:',
                                            value: '${user.user.region}'),
                                        textTile(
                                            attribute: 'State:',
                                            value: '${user.user.states}'),
                                      ],
                                    ),
                                  )
                                : textTile(
                                    attribute: 'Role:',
                                    value: '${user.user.role}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                updateButton(),
                                logoutButton(),
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    if (user.user.role != 'Guest') {
      return WillPopScope(onWillPop: (() async => false), child: body);
    }
    return body;
  }
}
