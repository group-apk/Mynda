import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:map_proj/new_api/test_api.dart';
import 'package:map_proj/new_model/question_model.dart';
import 'package:map_proj/new_model/test_model.dart';
import 'package:map_proj/new_notifier/test_notifier.dart';
import 'package:map_proj/new_view/question_edit.dart';
import 'package:provider/provider.dart';

class EditTestScreen extends StatefulWidget {
  const EditTestScreen({Key? key, required this.testName}) : super(key: key);
  final String testName;
  @override
  State<EditTestScreen> createState() => _EditTestScreenState();
}

class _EditTestScreenState extends State<EditTestScreen> {
  final _formKey = GlobalKey<FormState>();

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
    // setState(() {
    //   questionLength = _currentTestModel.questions!.length;
    // });
    // _currentTestModel.questions?.forEach((element) { 
    //   questionLength++;
    // });

    Widget questionField(TestModel _currentTestModel) {
      
      /*
    return FutureBuilder(
      future: getQuestionFuture(_currentTestModel),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: _currentTestModel.questions?.length ?? 0,
          itemBuilder: ((context, i) => ListTile(
                title: Text('${_currentTestModel.questions![i].question}'),
                subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                        // [
                        _currentTestModel.questions![i].answer!
                            .map((e) => Text(e))
                            .toList()),
              )),
        );
      },
    );
    */

      return Consumer<TestNotifier>( builder: (context, value, child) => FutureBuilder(
          future: getQuestionFuture(_currentTestModel),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            questionLength = _currentTestModel.questions!.length;
            return ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _currentTestModel.questions?.length ?? 0,
                itemBuilder: ((context, i) => ListTile(
                      title: Text('Question ${i + 1}'),
                      subtitle:
                          Text('${_currentTestModel.questions![i].question}'),
                      trailing: const Icon(Icons.edit),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditQuestionScreen(
                                      index: i,
                                      isAdd: false,
                                    )));
                      },
                    )),
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Colors.black,
                  );
                },
              );
          },
        ),
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
          print(questionLength);
          if (_formKey.currentState!.validate()) {
            _currentTestModel.questions!.add(QuestionModel());
            _currentTestModel.questions![questionLength].question = "";
            _currentTestModel.questions![questionLength].answer = [""];
            addNewQuestion(_currentTestModel, questionLength);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditQuestionScreen(
                        index: questionLength, isAdd: true)));
          }
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
          FloatingActionButton(
              backgroundColor: Colors.red,
              child: Icon(Icons.delete),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  testNotifier.deleteTest(_currentTestModel);
                  deleteTest(_currentTestModel).then((value) {
                    Fluttertoast.showToast(msg: "Test deleted");
                    Navigator.of(context).pop();
                  });
                }
              }),
          SizedBox(width: 10),
          FloatingActionButton(
            backgroundColor: Colors.green[900],
            child: Icon(Icons.save),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _currentTestModel.testName = testNameEditingController.text;
                updateTest(_currentTestModel).then((value) {
                  Fluttertoast.showToast(msg: "Test name updated");
                  // Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: ((context) => EditTestScreen(
                          testName: testNameEditingController.text))));
                });
              }
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Test Edit'),
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
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Edit ${widget.testName} Test",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    testNameField(_currentTestModel),
                    SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "List of questions in this test",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    addQuestionButton,
                    SizedBox(height: 15),
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
