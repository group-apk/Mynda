import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map_proj/new_model/question_model.dart';

class TestModel{
  String? id, testName;
  List<QuestionModel>? questions;

  TestModel.fromMap(Map<String, dynamic> data){
    id = data['id'];
    testName = data['testName'];
    questions = data['questions'];
  }

  // TestModel({
  //   id, testName, questions
  // }){
  //   this.id = id;
  //   this.testName = testName;
  //   this.questions = questions;
  // }

  TestModel();

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'testName': testName,
      'questions': questions,
    };
  }
}