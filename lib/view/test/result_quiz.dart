// ignore_for_file: deprecated_member_use, unnecessary_const, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mynda/model/result_model.dart';
import 'package:mynda/provider/result_provider.dart';
import 'package:mynda/view/test/category_view.dart';
import 'package:mynda/view/dashboard.dart';
import 'package:provider/provider.dart';
import '../../model/question_model.dart';
import '../../provider/article_notifier.dart';
import '../../services/api.dart';

class ResultScreen extends StatefulWidget {
//  final List<String> dropdownValueAnswer = []; //simpan list of answer
  //List<QuestionModel> dropdownValueQuestion=[]; //simpan list of question utk dapatkan option
  const ResultScreen({Key? key, required this.dropdownValueAnswer, required this.dropdownValueQuestion, required this.namaTest}) : super(key: key);
  final List<String> dropdownValueAnswer;
  final List<QuestionModel>? dropdownValueQuestion;
  final String namaTest;
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int score = 0;
  String result = "";
  int worstMark = 1;
  int divided = 0;
  late int cat1, cat2, cat3, cat4, cat5;

  late final ResultModel _currentResultModel = ResultModel(
    "",
    0,
    "",
    Timestamp.now(),
  );

  Future uploadResult(ResultModel currentResultModel) async {
    ResultProvider resultProvider = Provider.of<ResultProvider>(context, listen: false);
    currentResultModel = await uploadNewResult(currentResultModel);
    getResult(resultProvider);
  }

  void calcScore() {
    for (int i = 0; i < widget.dropdownValueQuestion!.length; i++) {
      //tolak 1 sbb markah jawapan a start ngn 0 bukan 1
      worstMark--;
      for (int j = 0; j < widget.dropdownValueQuestion![i].option!.length; j++) {
        //calculatehighestmarkcouldget(kalau ada 4 option, ada 0+1+2=3)
        worstMark++;
        if (widget.dropdownValueAnswer[i] == widget.dropdownValueQuestion![i].option![j]) {
          score = score + j;
        }
      }
    }
  }

  void resultText() {
    //calculate worst marks could get(done on calcScore())
    //divide by 5 category (minimal,mild,moderate,moderately severe,severe) =divided
    //eg:
    //questions=10 (2 options each, 0mark and 1 mark)
    //worstMark=10
    divided = (worstMark ~/ 5); //divided=2
    cat1 = 0 + divided; //cat1=2
    cat2 = cat1 + divided; //cat2=4
    cat3 = cat2 + divided; //cat3=6
    cat4 = cat3 + divided; //cat4=8
    cat5 = cat4 + divided; //cat5=10

    if (score <= 0) {
      result = "No";
    }
    if (score >= 1 && score <= cat1) {
      result = "Minimal";
    }
    if (score > cat1 && score <= cat2) {
      result = "Mild";
    }
    if (score > cat2 && score <= cat3) {
      result = "Moderate";
    }
    if (score > cat3 && score <= cat4) {
      result = "Moderately Severe";
    }
    if (score > cat4 && score <= cat5) {
      result = "Severe";
    }
    _currentResultModel.marks = score;
    _currentResultModel.quizTitle = widget.namaTest;
    uploadResult(_currentResultModel);
  }

  @override
  Widget build(BuildContext context) {
    calcScore();
    resultText();
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              "$result Symptom",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 45.0,
          ),
          const Text(
            "You Score is",
            style: TextStyle(color: Colors.white, fontSize: 34.0),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            "$score",
            style: const TextStyle(
              color: Colors.orange,
              fontSize: 85.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 100.0,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoryScreen(),
                  ));
            },
            shape: const StadiumBorder(),
            color: Colors.lightGreen,
            padding: const EdgeInsets.all(18.0),
            child: const Text(
              "Take another assessment",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardMain(),
                  ));
            },
            shape: const StadiumBorder(),
            color: const Color.fromARGB(255, 21, 48, 96),
            padding: const EdgeInsets.all(18.0),
            child: const Text(
              "Back to home page",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
