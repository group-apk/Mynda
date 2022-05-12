import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map_proj/main.dart';

class DashboardScreenMember extends StatefulWidget {
  const DashboardScreenMember({Key? key}) : super(key: key);

  @override
  State<DashboardScreenMember> createState() => _DashboardScreenMemberState();
}

class _DashboardScreenMemberState extends State<DashboardScreenMember> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  //signout function
  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyApp()));
  }

  Widget notificationDrawer() => Drawer(
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
                    Text('Available soon.'),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget logoutButton() => FloatingActionButton(
        onPressed: () async {
          await auth.signOut();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const MyApp()));
        },
        child: const Icon(Icons.logout_rounded),
        backgroundColor: Colors.blue,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: logoutButton(),
      endDrawer: notificationDrawer(),
      body: SafeArea(
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hi, Member !',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '${auth.currentUser!.email}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
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
                margin: const EdgeInsets.all(8),
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
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text('Test will be available soon.'),
                              ));
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
              child: Card(
                margin: const EdgeInsets.all(8),
                elevation: 5,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Articles:'),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                              child: MaterialButton(
                                  color: Colors.blue[300],
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                          'Articles will be available soon.'),
                                    ));
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
                              margin: EdgeInsets.all(10),
                              child: SizedBox(
                                child: Center(child: Text('articles here')),
                              ),
                            ),
                          ),
                          Expanded(
                              child: MaterialButton(
                                  color: Colors.blue[300],
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                          'Articles will be available soon.'),
                                    ));
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
          ],
        ),
      ),
    );
  }
}
