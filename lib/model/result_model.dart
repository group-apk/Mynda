
import 'package:cloud_firestore/cloud_firestore.dart';

class ResultModel {
  late String  quizTitle,id;
  Timestamp? createdAt;
  late int marks;

  ResultModel.fromMap(Map<String, dynamic> data) {
    marks = data['marks'];
    quizTitle = data['quizTitle'];
    id = data['id'];
    createdAt = data['createdAt'];
  }

  ResultModel(this.id,this.marks,this.quizTitle,this.createdAt);

  Map<String, dynamic> toMap() {
    return {
      'marks': marks,
      'id': id,
      'quizTitle': quizTitle,
      'createdAt': createdAt,
    };
  }
}
