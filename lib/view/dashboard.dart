import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map_proj/new_view/test_category_screen.dart';
import 'package:map_proj/playquiz_view/category_view.dart';
import 'package:map_proj/profile_screen.dart';
import 'package:map_proj/provider/user_provider.dart';
import 'package:map_proj/view/login_screen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DashboardMain extends StatefulWidget {
  const DashboardMain({Key? key, this.index = 0}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final int index;

  @override
  State<DashboardMain> createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  

  @override
  Widget build(BuildContext context) {
    var userProvider = context.read<UserProvider>();
    final List<Widget> _widgetOptions = [
      const HomepageScreen(),
      // const HealthTestCategoryScreen(),
      (userProvider.user.role == 'staff') ? const HealthTestCategoryScreen() : const CategoryScreen(),
      Container(),
      Container(),
      const ProfileScreen()
    ];
    return Scaffold(
      bottomNavigationBar: bottomNavigator(context),
      endDrawer: const NotificationDrawer(),
      body: Center(child: _widgetOptions.elementAt(widget.index)),
    );
  }

  Widget bottomNavigator(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.index,
      onTap: (value) {
        switch (value) {
          // case 1:
          //   snackbar(text: 'Tests will be available soon.');
          //   break;
          case 2:
            snackbar(text: 'Articles will be available soon.');
            break;
          case 3:
            snackbar(text: 'Appointments will be available soon.');
            break;
          // case 4:
          //   snackbar(text: 'Profile will be available soon.');
          //   break;
          default:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => DashboardMain(index: value))));
        }
      },
      selectedFontSize: 12,
      unselectedFontSize: 12,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted), label: "Tests"),
        BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "Articles"),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month), label: "Appointments"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }

  void snackbar(
      {required String text, Duration duration = const Duration(seconds: 1)}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: duration,
      behavior: SnackBarBehavior.floating,
      content: Text(text),
    ));
  }
}

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = context.read<UserProvider>();

    void snackbar(
        {required String text,
        Duration duration = const Duration(seconds: 1)}) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: duration,
        behavior: SnackBarBehavior.floating,
        content: Text(text),
      ));
    }

    Widget greet() {
      if (provider.user.role != 'Guest') {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, ${provider.user.fullName}.',
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              'Registered as a ${provider.user.role}!',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        );
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi, ${provider.user.role}.',
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            'Registered as a ${provider.user.role}!',
            style: const TextStyle(color: Colors.white),
          ),
          MaterialButton(
            color: Colors.blue[100],
            textColor: Colors.blue,
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: const Text('Login'),
          )
        ],
      );
    }

    Widget homepageGuestContent = SafeArea(
      child: Column(
        children: [
          Expanded(
              child: Container(
            color: Colors.blue[300],
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                children: [
                  Expanded(
                    child: greet(),
                    flex: 3,
                  ),
                  Expanded(
                    child: Builder(builder: (context) {
                      return MaterialButton(
                        shape: const CircleBorder(),
                        color: Colors.blue[100],
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                        child: const Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                      );
                    }),
                    // child: Container(),
                  ),
                ],
              ),
            ),
          )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              elevation: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 200,
                          child: Image.asset(
                            "assets/dashboard.png",
                            fit: BoxFit.contain,
                          )),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Unsure what to do?'),
                        MaterialButton(
                          color: Colors.blue[300],
                          onPressed: () {
                            // snackbar(text: 'Test will be available soon.');
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardMain(index: 1,),));
                          },
                          child: const Text(
                            'Take a test!',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                elevation: 5,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Text('Articles:'),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                              child: MaterialButton(
                                  color: Colors.blue[300],
                                  onPressed: () {
                                    snackbar(
                                        text:
                                            'Articles will be available soon.');
                                  },
                                  shape: const CircleBorder(),
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    size: 16,
                                  ))),
                          const Expanded(
                            flex: 6,
                            child: Card(
                              elevation: 5,
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              child: SizedBox(
                                child: Center(
                                    child: Text('Articles will be here soon!')),
                              ),
                            ),
                          ),
                          Expanded(
                              child: MaterialButton(
                                  color: Colors.blue[300],
                                  onPressed: () {
                                    snackbar(
                                        text:
                                            'Articles will be available soon.');
                                  },
                                  shape: const CircleBorder(),
                                  child: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                  ))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Widget homepageMemberContent = WillPopScope(
      onWillPop: (() async => false),
      child: homepageGuestContent,
    );
    Widget homepageStaffContent = WillPopScope(
      onWillPop: (() async => false),
      child: homepageGuestContent,
    );

    if (provider.user.role == 'member') {
      return homepageMemberContent;
    }
    else if (provider.user.role == 'staff') {
      return homepageStaffContent;
    }
    return homepageGuestContent;
  }
}

class NotificationDrawer extends StatefulWidget {
  const NotificationDrawer({Key? key}) : super(key: key);

  @override
  State<NotificationDrawer> createState() => _NotificationDrawerState();
}

class _NotificationDrawerState extends State<NotificationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                      'Get notified on the latest articles and your appointments!'),
                  Text('Register now to unlock this feature!'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
