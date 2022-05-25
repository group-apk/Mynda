import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});


  getQuizData() async {
    return FirebaseFirestore.instance.collection("QuizList").snapshots();
  }

  getQuestionData(String quizId) async{
    return await FirebaseFirestore.instance
        .collection("QuizList")
        .doc(quizId)
        .collection("Questions")
        .get();
  }
}