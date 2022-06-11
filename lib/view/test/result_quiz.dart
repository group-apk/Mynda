// ignore_for_file: deprecated_member_use, unnecessary_const

import 'package:flutter/material.dart';
import 'package:mynda/view/test/category_view.dart';
import 'package:mynda/view/dashboard.dart';

import '../../model/question_model.dart';

class ResultScreen extends StatefulWidget {
//  final List<String> dropdownValueAnswer = []; //simpan list of answer
  //List<QuestionModel> dropdownValueQuestion=[]; //simpan list of question utk dapatkan option
  const ResultScreen({Key? key, required this.dropdownValueAnswer,required this.dropdownValueQuestion, required this.namaTest})
      : super(key: key);
  final List<String> dropdownValueAnswer;
  final List<QuestionModel>? dropdownValueQuestion;
  final String namaTest;
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int score = 0;
  String result="";


  void calcScore() {
    for(int i=0;i<widget.dropdownValueQuestion!.length;i++)
    {
      for(int j=0;j<widget.dropdownValueQuestion![i].option!.length;j++){
        if(widget.dropdownValueAnswer[i]==widget.dropdownValueQuestion![i].option![j])
        {
          score=score+j;
        }
      }
    }

  }


  void resultText()
  {
    if(score<=0)
    {
      result="No";
    }
    if(score>=1 && score<=4)
    {
      result="Minimal";
    }
    if(score>=5 && score<=9)
    {
      result="Mild";
    }
    if(score>=10 && score<=14)
    {
      result="Moderate";
    }
    if(score>=15 && score<=19)
    {
      result="Moderately Severe";
    }
    if(score>=20 && score<=27)
    {
      result="Severe";
    }
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
