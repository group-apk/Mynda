import 'package:flutter/material.dart';
import 'package:map_proj/new_api/test_api.dart';
import 'package:map_proj/new_notifier/test_notifier.dart';
import 'package:map_proj/new_view/add_test.dart';
import 'package:map_proj/new_view/test_question_edit_screen.dart';
import 'package:provider/provider.dart';

class HealthTestCategoryScreen extends StatefulWidget {
  @override
  _HealthTestCategoryScreenState createState() =>
      _HealthTestCategoryScreenState();
}

class _HealthTestCategoryScreenState extends State<HealthTestCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    var testProvider = context.read<TestNotifier>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddTestScreen()));
        },
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Health Assessment Manager'),
        titleTextStyle: const TextStyle(
            color: Colors.blue, fontSize: 20.0, fontWeight: FontWeight.bold),
        elevation: 2,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF0069FE),
          ),
          onPressed: () {
            // passing this to root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Consumer<TestNotifier>( builder: (context, value, child) => GridView.count(
              shrinkWrap: true,
              primary: false,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              crossAxisCount: 2,
              children: testProvider.testList
                  .map((e) => Card(
                        elevation: 5,
                        shadowColor: Colors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${e.testName}'),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),

          //  child: FutureBuilder(
          //   future: getTestFuture(testProvider),
          //   builder: ((context, snapshot) {
          //     if(snapshot.connectionState == ConnectionState.waiting){
          //       return const Center(child: CircularProgressIndicator());
          //     }
              
          //     return Consumer<TestNotifier>( 
          //       builder: (context, value, child) => GridView.count(
          //       shrinkWrap: true,
          //       primary: false,
          //       crossAxisSpacing: 20,
          //       mainAxisSpacing: 20,
          //       crossAxisCount: 2,
          //       children: testProvider.testList
          //           .map((e) => Card(
          //                 elevation: 5,
          //                 shadowColor: Colors.blue,
          //                 child: Column(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     Text('${e.testName}'),
          //                   ],
          //                 ),
          //               ))
          //           .toList(),
          //                 ),
          //     );
          //   }) ,
          // ),

            // testNotifier.currentTestModel.testName.map((testname) => Card(child:Center(child: Text(testname, style: const TextStyle(
            //               color: Colors.white,
            //               fontSize: 22.0,
            //               fontWeight: FontWeight.bold,
            //             )),)))
            /*
                [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HealthTestEditScreen(
                                  testName: 'Psychosis')));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 10, 25, 190)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "Psychosis Test",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                */
        ),
      ),
    );
  }
}
