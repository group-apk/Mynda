import 'package:flutter/material.dart';
import 'package:map_proj/new_api/test_api.dart';
import 'package:map_proj/new_notifier/test_notifier.dart';
import 'package:map_proj/playquiz_view/quiz_play2.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() =>
      _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int i = 0;
  @override

  void initState(){
    TestNotifier testNotifier = Provider.of<TestNotifier>(context, listen: false);
    getTest(testNotifier);
    super.initState();
  }

  int checkTestName(String name){
    int index = 0;
    TestNotifier testNotifier = Provider.of<TestNotifier>(context, listen: false);
    for(int i = 0; i < testNotifier.testList.length; i++){
      if(name == testNotifier.testList[i].quizTitle){
        index = i;
      }
    }
    return index;
  }

  @override
  Widget build(BuildContext context) {
    TestNotifier testNotifier = Provider.of<TestNotifier>(context, listen: false);
    var testProvider = context.read<TestNotifier>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Mental Health Assessment'),
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
            future: getTestFuture(testProvider),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              return Consumer<TestNotifier>(
                builder: (context, value, child) => GridView.count(
                  shrinkWrap: true,
                  primary: false,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                  children: testProvider.testList
                      .map((e) => GestureDetector(
                            onTap: () {
                              testNotifier.currentTestModel = testNotifier.testList[checkTestName('${e.quizTitle}')];
                              // getQuestion(testNotifier.currentTestModel);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QuestionPlay(
                                          testName: '${e.quizTitle}')));
                            },
                            child:  Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                height: 150,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        '${e.quizImgurl}',
                                        fit: BoxFit.cover,
                                        width: MediaQuery.of(context).size.width,
                                        height: 250,
                                       
                                      ),
                                      Container(
                                        color: Colors.black26,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${e.quizTitle}',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
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
    );
  }
}
