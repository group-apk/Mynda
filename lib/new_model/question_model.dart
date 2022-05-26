import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel{
  String? question;
  List? answer;

  QuestionModel.fromMap(Map<String, dynamic> data){
    question = data['question'];
    answer = data['answer'];
  }

  Map<String, dynamic> toMap(){
    return{
      'question': question,
      'answer': answer
    };
  }
}