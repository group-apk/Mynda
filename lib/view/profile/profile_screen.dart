import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mynda/provider/dashboard_provider.dart';
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
    final user = context.read<UserProvider>();
    final dashboard = context.read<DashboardProvider>();
    final navigator = Navigator.of(context);

    Map<String, String> userMap = {
      'Name': '${user.user.fullName}',
      'IC': '${user.user.ic}',
      'Gender': '${user.user.gender}',
      'Role': (user.user.role == 'staff')
          ? 'Staff'
          : (user.user.role == 'member')
              ? 'Member'
              : 'Guest',
      'Email': '${user.user.email}',
      'Academic': '${user.user.academic}',
      'Region': '${user.user.region}',
      'State': '${user.user.states}',
    };

    signOut() async {
      await auth.signOut().then((value) {
        user.logout();
        navigator.pushReplacement(MaterialPageRoute(builder: (context) => const LandingScreen()));
      });
    }

    Widget button({required String title, required void Function()? onPressed}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: MaterialButton(
          highlightElevation: 0,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          color: Colors.blue,
          textColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            title,
            style: GoogleFonts.robotoCondensed(
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    Widget body = SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            color: Colors.blue[50],
            margin: const EdgeInsets.symmetric(horizontal: 15),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      color: Colors.blue,
                      margin: const EdgeInsets.only(bottom: 5),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          'PROFILE',
                          textScaleFactor: 2,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.robotoCondensed(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: Colors.blue,
                      child: Card(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: IntrinsicHeight(
                              child: Consumer<UserProvider>(builder: (context, user, child) {
                                userMap = {
                                  'Name': '${user.user.fullName}',
                                  'IC': '${user.user.ic}',
                                  'Gender': '${user.user.gender}',
                                  'Role': (user.user.role == 'staff')
                                      ? 'Staff'
                                      : (user.user.role == 'member')
                                          ? 'Member'
                                          : 'Guest',
                                  'Email': '${user.user.email}',
                                  'Academic': '${user.user.academic}',
                                  'Region': '${user.user.region}',
                                  'State': '${user.user.states}',
                                };

                                return Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: (userMap['Role'] != 'Guest')
                                                ? userMap.entries.map<Widget>((e) {
                                                    // (e.key == ['Role'] && e.value != 'staff') ?
                                                    return (e.key == 'Academic' && userMap['Role'] != 'staff')
                                                        ? Container()
                                                        : Text(
                                                            e.key,
                                                            style: GoogleFonts.robotoCondensed(),
                                                          );
                                                    // return Text(e.value);
                                                  }).toList()
                                                : [
                                                    Text(
                                                      'Role',
                                                      style: GoogleFonts.robotoCondensed(),
                                                    ),
                                                  ]),
                                      ),
                                    ),
                                    const Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 10),
                                        child: VerticalDivider(
                                          thickness: 2,
                                          color: Colors.black26,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: (userMap['Role'] != 'Guest')
                                                ? userMap.entries.map<Widget>((e) {
                                                    return (e.key == 'Academic' && userMap['Role'] != 'staff')
                                                        ? Container()
                                                        : Text(
                                                            e.value,
                                                            style: GoogleFonts.robotoCondensed(),
                                                          );
                                                  }).toList()
                                                : [
                                                    Text(
                                                      userMap['Role'].toString(),
                                                      style: GoogleFonts.robotoCondensed(),
                                                    ),
                                                  ]),
                                      ),
                                    )
                                  ],
                                );
                              }),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10.0, top: 10),
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: (user.user.role != 'Guest')
                              ? [
                                  button(
                                      title: 'UPDATE',
                                      onPressed: () async {
                                        showDialog(barrierDismissible: false, context: context, builder: (context) => const EditProfileScreen());

                                        // navigator.push(
                                        //   MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         const EditProfileScreen(),
                                        //   ),
                                        // );
                                      }),
                                  button(
                                    title: 'LOGOUT',
                                    onPressed: () async {
                                      dashboard.setIndex = 0;
                                      await signOut();
                                    },
                                  ),
                                ]
                              : [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Login to unlock more features!',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.robotoCondensed(),
                                    ),
                                  ),
                                  button(
                                    title: 'LOGIN',
                                    onPressed: () {
                                      navigator.pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => const LoginScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    if (user.user.role != 'Guest') {
      return WillPopScope(onWillPop: (() async => false), child: body);
    }
    return body;
  }
}
