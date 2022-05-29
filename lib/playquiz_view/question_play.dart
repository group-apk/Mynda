import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:map_proj/new_api/test_api.dart';
import 'package:map_proj/new_model/test_model.dart';
import 'package:map_proj/new_notifier/test_notifier.dart';
import 'package:map_proj/new_view/question_edit.dart';
import 'package:provider/provider.dart';

import 'quiz_play_widgets.dart';

class QuestionPlay extends StatefulWidget {
  const QuestionPlay({Key? key, required this.testName}) : super(key: key);
  final String testName;
  
  @override
  State<QuestionPlay> createState() => _QuestionPlay();
}
int optionmarks = {0,1,2,3} as int;
int totalcollected = 0;
int totalMax=0;


class _QuestionPlay extends State<QuestionPlay> {
  final _formKey = GlobalKey<FormState>();

  late int optionSelected;

  @override
  Future updateTest(TestModel _currentTestModel) async {
    TestNotifier testNotifier =
        Provider.of<TestNotifier>(context, listen: false);
    updateExistingTest(_currentTestModel);
    getTest(testNotifier);
  }

  Future deleteTest(TestModel _currentTestModel) async {
    TestNotifier testNotifier =
        Provider.of<TestNotifier>(context, listen: false);
        deleteExistingTest(_currentTestModel);
        getTest(testNotifier);
  }

  
  Widget build(BuildContext context) {

    TestNotifier testNotifier =
        Provider.of<TestNotifier>(context, listen: false);
    TestModel _currentTestModel = testNotifier.currentTestModel;
    final testNameEditingController =
        TextEditingController(text: _currentTestModel.testName);

    int questionLength = 0;
    _currentTestModel.questions?.forEach((element) { 
      questionLength++;
    });

    Widget questionField(TestModel _currentTestModel) {
      return FutureBuilder(
      future: getQuestionFuture(_currentTestModel),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
          itemCount: _currentTestModel.questions?.length ?? 0,
          itemBuilder: ((context, i) => SizedBox(
            width:400,
            child: ListTile(
                  title: Text(
                    '\nQ${i + 1} ${_currentTestModel.questions![i].question}\n',
                    style:
                    TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.8)),
                    
                    ),
                  subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:
                          _currentTestModel.questions![i].answer!
                              .map((e) => 
                              GestureDetector(
                                
                                onTap:(){
                                    setState(() {
                                    //optionSelected = answer[i];
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(border:Border.all(
                                    color: Color.fromARGB(255, 4, 90, 160),
                                    width: 2, 
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(12))
                                  ),
                                  width:300,
                                  height: 50,
                                  //color: Color.fromARGB(255, 1, 60, 255),
                                  padding: const EdgeInsets.all(10),
                                  child: Text(e,
                                  textAlign: TextAlign.center,
                                  style:  TextStyle(fontSize: 20,color: Colors.black.withOpacity(1)),
                                  ),
                                ),
                              ),
                              ) 
                              .toList()
                    ),
                              
                ),
          )
              ),
        );
      },
    );
  }


    Widget testNameField(TestModel _currentTestModel) {
      return TextFormField(
        autofocus: false,
        // initialValue: _currentTestModel.testName,
        controller: testNameEditingController,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        style: TextStyle(fontSize: 20),
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please enter a test name");
          }
        },
        textInputAction: TextInputAction.next,
        onSaved: (value) {
          testNameEditingController.text = value!;
        },
        decoration: const InputDecoration(
            labelText: 'Test Name',
            suffixIcon: Align(
                widthFactor: 1.0, heightFactor: 1.0, child: Icon(Icons.edit))),
      );
    }

    final addQuestionButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(5),
      color: Color(0xFF0069FE),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: () {
          Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditQuestionScreen(index: questionLength, isAdd: true)));
        },
        child: Text(
          "Add New Question",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: 10),
          FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 27, 183, 255),
            child: Icon(Icons.done),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _currentTestModel.testName = testNameEditingController.text;
                updateTest(_currentTestModel).then((value) {
                  Fluttertoast.showToast(msg: "Test name updated");
                  // Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => QuestionPlay(testName: testNameEditingController.text))));
                });
              }
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("${widget.testName} Test"),
        titleTextStyle: TextStyle(
            color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.bold),
        elevation: 2,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF0069FE),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 5),
                    questionField(_currentTestModel),
                   
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
