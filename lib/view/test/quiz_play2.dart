// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:mynda/services/api.dart';
import 'package:mynda/model/question_model.dart';
import 'package:mynda/model/test_model.dart';
import 'package:mynda/provider/test_notifier.dart';
import 'package:mynda/view/test/result_quiz.dart';
import 'package:provider/provider.dart';

class QuestionPlay extends StatefulWidget {
  const QuestionPlay({Key? key, required this.testName}) : super(key: key);
  final String testName;

  @override
  State<QuestionPlay> createState() => _QuestionPlay();
}

class _QuestionPlay extends State<QuestionPlay> {
  final _formKey = GlobalKey<FormState>();

  String optionSelected = "";
  bool answerTap = false;
  int scorea = 0;
  int scoreGet = 0;
  int totalScore = 0;
  String optionChose = "";
  int index = 0;
  //1st :aku nak create dropdownValue as list so each dropdown can display its own dropdownValue(variable utk simpan jawapan yang dia pilih)
  // List<String?> dropdownValue = []; //code asal: String? dropdownValue;
  List<String> dropdownValueAnswer = [];

  @override
  Widget build(BuildContext context) {
    TestNotifier testNotifier = Provider.of<TestNotifier>(context, listen: false);
    TestModel currentTestModel = testNotifier.currentTestModel;

    Widget questionField(TestModel currentTestModel) {
      return FutureBuilder(
          future: getQuestionFuture(currentTestModel),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (dropdownValueAnswer.isEmpty) {
              dropdownValueAnswer = currentTestModel.questions!.map((e) => e.option![0] as String).toList();
            }

            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: currentTestModel.questions?.length ?? 0,
                itemBuilder: ((context, i) {
                  List<QuestionModel>? dropdownValueQuestion = currentTestModel.questions;

                  return SizedBox(
                    width: 400,
                    child: ListTile(
                      title: Text(
                        '\nQ${i + 1} ${dropdownValueQuestion![i].question}\n',
                        style: TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.8)),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        child: DropdownButton(
                          value: dropdownValueAnswer[i],
                          items: dropdownValueQuestion[i]
                              .option!
                              .map((e) => DropdownMenuItem(
                                    value: e as String,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (String? value) {
                            setState(() {
                              dropdownValueAnswer.insert(i, value as String);
                              dropdownValueAnswer.removeAt(i + 1);
                            });
                          },
                        ),
                      ),
                    ),
                  );
                }));
          });
    }

    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(width: 10),
          FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 27, 183, 255),
            child: const Icon(Icons.done),
            onPressed: () {
              print(dropdownValueAnswer[0]);
              print(currentTestModel.questions![0].option![0]);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultScreen(
                          dropdownValueAnswer: dropdownValueAnswer, dropdownValueQuestion: currentTestModel.questions, namaTest: widget.testName)));
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("${widget.testName} Test"),
        titleTextStyle: const TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.bold),
        elevation: 2,
        leading: IconButton(
          icon: const Icon(
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
                    const SizedBox(height: 5),
                    questionField(currentTestModel),
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
