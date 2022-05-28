import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:map_proj/new_api/test_api.dart';
import 'package:map_proj/new_model/question_model.dart';
import 'package:map_proj/new_model/test_model.dart';
import 'package:map_proj/new_notifier/test_notifier.dart';
import 'package:provider/provider.dart';

class EditQuestionScreen extends StatefulWidget {
  const EditQuestionScreen({Key? key, required this.index, required this.isAdd})
      : super(key: key);
  final int index;
  final bool isAdd;
  @override
  State<EditQuestionScreen> createState() => _EditQuestionScreenState();
}

class _EditQuestionScreenState extends State<EditQuestionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TestNotifier testNotifier =
        Provider.of<TestNotifier>(context, listen: false);
    TestModel _currentTestModel = testNotifier.currentTestModel;

    TextEditingController questionNameEditingController = widget.isAdd
        ? TextEditingController()
        : TextEditingController(
            text: _currentTestModel.questions![widget.index].question);

    List<TextEditingController> answerEditingController = [];
    _currentTestModel.questions![widget.index].answer?.forEach((element) {
      answerEditingController.add(TextEditingController(text: element));
    });

    Future updateQuestion(TestModel _currentTestModel) async {
      updateExistingQuestion(_currentTestModel, widget.index);
      getTest(testNotifier);
    }

    Future deleteQuestion(TestModel _currentTestModel) async {
      deleteExisitingQuestion(_currentTestModel, widget.index);
      testNotifier.deleteQuestion(_currentTestModel, widget.index);
      getTest(testNotifier);
    }

    Widget testQuestionField(TestModel _currentTestModel) {
      return TextFormField(
        autofocus: false,
        decoration: const InputDecoration(labelText: 'Question Name'),
        controller: questionNameEditingController,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        style: const TextStyle(fontSize: 20),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return ("Please enter a question name");
          }
          print('question: a${value} a');
          return null;
        },
        textInputAction: TextInputAction.next,
        onSaved: (value) {
          questionNameEditingController.text = value!;
        },
      );
    }

    Widget testAnswersField(TestModel _currentTestModel) {
      return FutureBuilder(
        future: getQuestionFuture(_currentTestModel),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return SingleChildScrollView(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:
                  _currentTestModel.questions![widget.index].answer?.length ??
                      0,
              itemBuilder: ((context, i) => TextFormField(
                    // key: _answerKey,
                    autofocus: false,
                    decoration: InputDecoration(
                        labelText: 'Answer ${i + 1}',
                        suffixIcon: widget.isAdd
                            ? IconButton(
                                onPressed: answerEditingController[i].clear,
                                icon: const Icon(Icons.clear))
                            : IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.delete),
                              )),
                    controller: answerEditingController[i],
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ("Please enter an answer");
                      }
                      print('answer: $value');
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    onSaved: (value) {
                      answerEditingController[i].text = value!;
                    },
                  )),
            ),
          );
        },
      );
    }

    print(_currentTestModel.questions![widget.index].qid);
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: FloatingActionButton(
                heroTag: 'delete',
                backgroundColor: Colors.red,
                child: const Icon(Icons.delete),
                onPressed: () {
                  deleteQuestion(_currentTestModel).then((value) {
                    Fluttertoast.showToast(msg: "Question deleted");
                    Navigator.of(context).pop();
                  });
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FloatingActionButton(
              heroTag: 'save',
              backgroundColor: Colors.green[900],
              child: const Icon(Icons.save),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print(widget.index);
                  _currentTestModel.questions![widget.index].question =
                      questionNameEditingController.text;
                  for (int i = 0; i < answerEditingController.length; i++) {
                    _currentTestModel.questions![widget.index].answer![i] =
                        answerEditingController[i].text;
                  }
                  updateQuestion(_currentTestModel).then((value) {
                    Fluttertoast.showToast(msg: "Question updated");
                    Navigator.of(context).pop();
                  });
                }
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Question Edit'),
        titleTextStyle: const TextStyle(
            color: Colors.blue, fontSize: 20.0, fontWeight: FontWeight.bold),
        elevation: 2,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF0069FE),
          ),
          onPressed: () {
            print(widget.isAdd);
            widget.isAdd
                ? deleteQuestion(_currentTestModel).then((value) {
                    Fluttertoast.showToast(msg: "Question Add cancelled");
                    Navigator.of(context).pop();
                  })
                : Navigator.of(context).pop();
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
                  children: [
                    Text(
                      widget.isAdd ? "Add new question" : "Question Editor",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    testQuestionField(_currentTestModel),
                    const SizedBox(height: 20),
                    testAnswersField(_currentTestModel),
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
