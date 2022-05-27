import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map_proj/new_model/question_model.dart';
import 'package:map_proj/new_model/test_model.dart';
import 'package:map_proj/new_notifier/test_notifier.dart';

getAllQuestions(List<TestModel> testModels) async {
  testModels.forEach((e) {
    getQuestion(e);
  });
}

getQuestion(TestModel testModel) async {
  if (testModel.id != null) {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('test')
        .doc(testModel.id)
        .collection('questions')
        .get();
    testModel.questions = snapshot.docs
        .map((e) => QuestionModel.fromMap(e.data() as Map<String, dynamic>))
        .toList();

/*
    print(testModel.id);
    if (testModel.questions!.isNotEmpty) {
      testModel.questions!.forEach((e) {
        print(e.question);
        e.answer!.forEach((e) {
          print(e);
        });
      });
    }
*/

  }
}

Future getQuestionFuture(TestModel testModel) async {
  if (testModel.id != null) {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('test')
        .doc(testModel.id)
        .collection('questions')
        .get();
    testModel.questions = snapshot.docs
        .map((e) => QuestionModel.fromMap(e.data() as Map<String, dynamic>))
        .toList();

/*
    print(testModel.id);
    if (testModel.questions!.isNotEmpty) {
      testModel.questions!.forEach((e) {
        print(e.question);
        e.answer!.forEach((e) {
          print(e);
        });
      });
    }
*/
  }
}

getTest(TestNotifier testNotifier) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('test').get();
  List<TestModel> _testList = snapshot.docs
      .map((e) => TestModel.fromMap(e.data() as Map<String, dynamic>))
      .toList();

  testNotifier.testList = _testList;
}

Future getTestFuture(TestNotifier testNotifier) async {
  getTest(testNotifier);
}

uploadNewTest(TestModel test) async {
  final CollectionReference db = FirebaseFirestore.instance.collection('test');
  var id = await db.add(test.toMap()).then((doc) => doc.id);
  // print(id);
  await db.doc(id).update({"id": id});
}

updateExistingTest(TestModel test) async {
  final CollectionReference db = FirebaseFirestore.instance.collection('test');
  // print("test model:"+ test.testName.toString());
  await db.doc(test.id).update({"testName": test.testName});
}

deleteExistingTest(TestModel test) async {
  final CollectionReference db = FirebaseFirestore.instance.collection('test');
  await db.doc(test.id).delete();
}

updateExistingQuestion(TestModel test, int index) async{
  final CollectionReference db = FirebaseFirestore.instance.collection('test').doc(test.id).collection('questions');
  await db.doc(test.questions![index].qid).update({"question": test.questions![index].question, "answer": test.questions![index].answer});
  print("question:" + test.questions![index].question.toString());
  print(test.questions![index].answer);
}

addNewQuestion(TestModel test, int index) async{
  final CollectionReference db = FirebaseFirestore.instance.collection('test').doc(test.id).collection('questions');
  var id = await db.add(test.questions![index].toMap()).then((doc) => doc.id);
  await db.doc(id).update({"qid": id});
}

// uploadNewTest(TestModel test) async {
//   final CollectionReference db = FirebaseFirestore.instance.collection('test');
//   var id = await db.add(test.toMap()).then((doc) => doc.id);
//   // print(id);
//   await db.doc(id).update({"id": id});
// }