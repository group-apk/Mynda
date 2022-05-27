import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:map_proj/new_api/test_api.dart';
import 'package:map_proj/new_model/question_model.dart';
import 'package:map_proj/new_model/test_model.dart';
import 'package:map_proj/new_notifier/test_notifier.dart';
import 'package:provider/provider.dart';

class EditQuestionScreen extends StatefulWidget {
  const EditQuestionScreen({Key? key, required this.index, required this.isAdd}) : super(key: key);
  final int index;
  final bool isAdd;
  @override
  State<EditQuestionScreen> createState() => _EditQuestionScreenState();
}

class _EditQuestionScreenState extends State<EditQuestionScreen> {
  final _formKey = GlobalKey<FormState>();

  @override

  Future updateQuestion(TestModel _currentTestModel) async{
    TestNotifier testNotifier = Provider.of<TestNotifier>(context, listen: false);
    updateExistingQuestion(_currentTestModel, widget.index);
    getTest(testNotifier);
  }

  Widget build(BuildContext context) {
    TestNotifier testNotifier =
        Provider.of<TestNotifier>(context, listen: false);
    TestModel _currentTestModel = testNotifier.currentTestModel;

    widget.isAdd ? _currentTestModel.questions!.add(QuestionModel()) : "";
    widget.isAdd ? _currentTestModel.questions![widget.index].answer = [""] : "";
    widget.isAdd ? addNewQuestion(_currentTestModel, widget.index) : "";

    final questionNameEditingController = widget.isAdd ? TextEditingController() : TextEditingController(
        text: _currentTestModel.questions![widget.index].question);

    // final questionNameEditingController = TextEditingController(
    //     text: _currentTestModel.questions![widget.index].question);

    List<TextEditingController> answerEditingController = [];
    _currentTestModel.questions![widget.index].answer?.forEach((element) { 
      answerEditingController.add(TextEditingController(text: element));
    });

    Widget testQuestionField(TestModel _currentTestModel) {
      return TextFormField(
        autofocus: false,
        decoration: InputDecoration(labelText: 'Question Name'),
        // initialValue: _currentTestModel.questions![widget.index].question,
        controller: questionNameEditingController,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        style: TextStyle(fontSize: 20),
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please enter a question name");
          }
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
            child: Column( children:<Widget>[ ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _currentTestModel.questions![widget.index].answer?.length,
              itemBuilder: ((context, i) => TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                        labelText: 'Answer ${i + 1}',
                        suffixIcon: widget.isAdd ? IconButton(onPressed: answerEditingController[i].clear, icon: const Icon(Icons.clear)) : IconButton(
                          onPressed: () {
          
                          },
                          icon: const Icon(Icons.delete),
                        )),
                    // initialValue: _currentTestModel.questions![widget.index].answer![i],
                    controller: answerEditingController[i],
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please enter an answer");
                      }
                    },
                    textInputAction: TextInputAction.done,
                    onSaved: (value) {
                      answerEditingController[i].text = value!;
                    },
                  )),
            ),]),
          );
        },
      );
    }

    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              backgroundColor: Colors.red,
              child: Icon(Icons.delete),
              onPressed: () {}),
          SizedBox(width: 10),
          FloatingActionButton(
            backgroundColor: Colors.green[900],
            child: Icon(Icons.save),
            onPressed: () {
              if(_formKey.currentState!.validate()){
                _currentTestModel.questions![widget.index].question = questionNameEditingController.text;
                for(int i = 0; i < answerEditingController.length; i++){
                  _currentTestModel.questions![widget.index].answer![i] = answerEditingController[i].text;
                }
              }
              updateQuestion(_currentTestModel).then((value){
                Fluttertoast.showToast(msg: "Question updated");
                Navigator.of(context).pop();
              });
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Question Edit'),
        titleTextStyle: TextStyle(
            color: Colors.blue, fontSize: 20.0, fontWeight: FontWeight.bold),
        elevation: 2,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF0069FE),
          ),
          onPressed: () {
            // passing this to root
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
                      widget.isAdd ? "Add new question" : "Question Editor",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    testQuestionField(_currentTestModel),
                    SizedBox(height: 20),
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
