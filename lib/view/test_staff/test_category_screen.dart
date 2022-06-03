import 'package:flutter/material.dart';
import 'package:mynda/provider/test_notifier.dart';
import 'package:mynda/services/api.dart';
import 'package:mynda/view/test_staff/add_test.dart';
import 'package:mynda/view/test_staff/question_manager.dart';
import 'package:provider/provider.dart';

class HealthTestCategoryScreen extends StatefulWidget {
  const HealthTestCategoryScreen({Key? key}) : super(key: key);

  @override
  State<HealthTestCategoryScreen> createState() =>
      _HealthTestCategoryScreenState();
}

class _HealthTestCategoryScreenState extends State<HealthTestCategoryScreen> {
  int i = 0;

  @override
  void initState() {
    TestNotifier testNotifier =
        Provider.of<TestNotifier>(context, listen: false);
    getTest(testNotifier);
    super.initState();
  }

  int checkTestName(String name) {
    int index = 0;
    TestNotifier testNotifier =
        Provider.of<TestNotifier>(context, listen: false);
    for (int i = 0; i < testNotifier.testList.length; i++) {
      if (name == testNotifier.testList[i].quizTitle) {
        index = i;
      }
    }
    return index;
  }

  @override
  Widget build(BuildContext context) {
    TestNotifier testNotifier =
        Provider.of<TestNotifier>(context, listen: false);
    Widget body = WillPopScope(
      onWillPop: (() async => false),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddTestScreen()));
          },
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Health Assessment Manager'),
          titleTextStyle: const TextStyle(
              color: Colors.blue, fontSize: 20.0, fontWeight: FontWeight.bold),
          elevation: 2,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: FutureBuilder(
              future: getTestFuture(testNotifier),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Consumer<TestNotifier>(
                  builder: (context, value, child) => GridView.count(
                    shrinkWrap: true,
                    primary: false,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 2,
                    children: testNotifier.testList
                        .map((e) => InkWell(
                              onTap: () {
                                testNotifier.currentTestModel = testNotifier
                                    .testList[checkTestName('${e.quizTitle}')];
                                // getQuestion(testNotifier.currentTestModel);
                                // edit test variables
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditTestScreen(
                                            testName: '${e.quizTitle}')));
                              },
                              child: Card(
                                elevation: 5,
                                shadowColor: Colors.blue,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('${e.quizTitle}'),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );

    return body;
  }
}
