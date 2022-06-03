import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:map_proj/new_api/test_api.dart';
import 'package:map_proj/new_model/test_model.dart';
import 'package:map_proj/new_notifier/test_notifier.dart';
import 'package:map_proj/playquiz_view/quiz_play_widgets.dart';
import 'package:map_proj/view/category_quiz.dart';
import 'package:provider/provider.dart';

class QuestionPlay extends StatefulWidget {
  const QuestionPlay({Key? key, required this.testName}) : super(key: key);
  final String testName;
  
  @override
  State<QuestionPlay> createState() => _QuestionPlay();
}




class _QuestionPlay extends State<QuestionPlay> {
  final _formKey = GlobalKey<FormState>();

  String optionSelected="";
  bool answerTap =false;
  int scorea=0;
  int scoreGet=0;
  int totalScore = 0;
  String optionChose="";
  int index=0;
  //1st :aku nak create dropdownValue as list so each dropdown can display its own dropdownValue(variable utk simpan jawapan yang dia pilih)
  List<String?> dropdownValue[i]; //code asal: String? dropdownValue;

  
  @override
  Widget build(BuildContext context) {
    TestNotifier testNotifier =
        Provider.of<TestNotifier>(context, listen: false);
    TestModel _currentTestModel = testNotifier.currentTestModel;
    final testNameEditingController =
        TextEditingController(text: _currentTestModel.quizTitle);

    Widget questionField(TestModel _currentTestModel) {
      return FutureBuilder(
      future: getQuestionFuture(_currentTestModel),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
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
                  subtitle:  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: DropdownButton(
                      //2nd:aku nak dropdownValue keluar ikut index lpas declared as List (index tu kalau bleh nak ikut index soalan)
                        value: dropdownValue[i], //code asal: value:dropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        style: const TextStyle(color:  Color.fromARGB(255, 7, 68, 97)),
                        underline: Container(
                        height: 2,
                        color: const Color.fromARGB(255, 27, 183, 255),
                      ),
                      
                        items: _currentTestModel.questions![i].option!.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                            
                          );
                        }).toList(),
                        onChanged: (val) async {
                            setState(() => 
                            //3rd: bila ada perubahan, dia store dalam each index dropdownValue tu (index tu nak guna index soalan)
                        dropdownValue[i] = val as String); //code asal: dropdownValue= val as String);
                        } 
                        //4rd: nak guna for loop untuk loop balik semula dropdownValue[] untuk kira each score by using if(a),else if(b)etc
                      ),
                  ),          
                  ),
          )),
        );
      },
      );
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

            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("${widget.testName} Test"),
        titleTextStyle: const TextStyle(
            color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.bold),
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
