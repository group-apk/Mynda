import 'package:flutter/material.dart';

import '../new_view/test_category_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    const Expanded(
                      child: Text(
                        'Hi, name !',
                        style: TextStyle(color: Colors.white),
                      ),
                      flex: 3,
                    ),
                    Expanded(
                      child: MaterialButton(
                        shape: const CircleBorder(),
                        color: Colors.blue[100],
                        onPressed: () {},
                        child: const Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        child: Center(
                          child: Text('image here'),
                        ),
                      ),
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
                             Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HealthTestCategoryScreen()
                                //CategoryScreen()
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
            )),
            Expanded(
              child: Column(
                children: const [
                  Text('Articles:'),
                  Expanded(
                    child: Card(
                      margin: EdgeInsets.all(15),
                      child: SizedBox(
                        child: Center(child: Text('articles here')),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
