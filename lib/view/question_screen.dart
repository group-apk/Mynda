import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:map_proj/view/question_card.dart';
import 'package:map_proj/widget/widget.dart';

import '../model/question_model.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({required this.questionsId});

  final String questionsId;


  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {

  List<Object> _questionList=[];

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    getCategoryQuestionList(widget.questionsId);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.questionsId);
    return Scaffold(
      appBar:  AppBar(
        title: AppLogo(),
        elevation: 0.0,
        backgroundColor: Colors.transparent, systemOverlayStyle: SystemUiOverlayStyle.dark,
        //brightness: Brightness.li,
      ),
      body: SafeArea(
          child: ListView.builder(
            itemCount: _questionList.length,
            itemBuilder: (context, index){
              return QuestionCard(_questionList[index] as Question);
            },
          ),
          ),
    );
  }

  Future getCategoryQuestionList(String questionsId) async{

    var data= await FirebaseFirestore.instance
    .collection('QuizList')
    .doc(questionsId)
    .collection('Questions')
    .get();

    setState((){
      _questionList=List.from(data.docs.map((doc)=>Question.fromSnapshot(doc)));
    });
 
  }
}
