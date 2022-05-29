import 'package:flutter/material.dart';
import 'package:map_proj/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var currentIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Tests Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Articles Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Appointment Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigator(context),
      endDrawer: const NotificationDrawer(),
      body: Center(child: _widgetOptions.elementAt(currentIndex)),
    );
  }

  Widget bottomNavigator(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) {
        switch (value) {
          case 1:
            snackbar(text: 'Tests will be available soon.');
            break;
          case 2:
            snackbar(text: 'Articles will be available soon.');
            break;
          default:
            setState(() {
              currentIndex = value;
            });
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

  Widget dashboardBody() {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
              child: Container(
            color: Colors.blue[300],
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Hi, Guest !',
                      style: TextStyle(color: Colors.white),
                    ),
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
                            snackbar(text: 'Test will be available soon.');
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
                                child: Center(child: Text('articles here')),
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
