import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map_proj/new_model/question_model.dart';
import 'package:map_proj/new_model/test_model.dart';
import 'package:map_proj/new_notifier/test_notifier.dart';

getQuestion(TestModel testModel) async {
  if (testModel.quizId != null) {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('QuizList')
        .doc(testModel.quizId)
        .collection('Questions')
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
  if (testModel.quizId != null) {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('QuizList')
        .doc(testModel.quizId)
        .collection('Questions')
        .orderBy('createdAt')
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
      await FirebaseFirestore.instance.collection('QuizList').get();
  List<TestModel> _testList = snapshot.docs
      .map((e) => TestModel.fromMap(e.data() as Map<String, dynamic>))
      .toList();

  testNotifier.testList = _testList;
}

Future getTestFuture(TestNotifier testNotifier) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('QuizList').get();
  List<TestModel> _testList = snapshot.docs
      .map((e) => TestModel.fromMap(e.data() as Map<String, dynamic>))
      .toList();

  testNotifier.testList = _testList;
}

Future<TestModel> uploadNewTest(TestModel test) async {
  final CollectionReference db = FirebaseFirestore.instance.collection('QuizList');
  // var id = await db.add(test.toMap()).then((doc) => doc.id);
  test.quizId = await db.add({'quizTitle': test.quizTitle}).then((doc) => doc.id);
  // print('upload test id: ${id}');
  await db.doc(test.quizId).update({"quizId": test.quizId});
  return test;
}

updateExistingTest(TestModel test) async {
  final CollectionReference db = FirebaseFirestore.instance.collection('QuizList');
  // print("test model:"+ test.testName.toString());
  await db.doc(test.quizId).update({"quizTitle": test.quizTitle});
}

deleteExistingTest(TestModel test) async {
  final CollectionReference db = FirebaseFirestore.instance.collection('QuizList');
  await db.doc(test.quizId).delete();
}

updateExistingQuestion(TestModel test, int index) async {
  // print('updateqid: ${test.questions![index].qid}');
  final CollectionReference db = FirebaseFirestore.instance
      .collection('QuizList')
      .doc(test.quizId)
      .collection('Questions');

  await db.doc(test.questions![index].qid).set({
    "createdAt": Timestamp.now(),
    "qid": test.questions![index].qid,
    "question": test.questions![index].question,
    "option": test.questions![index].option
  });
  // print("question:" + test.questions![index].question.toString());
  // print(test.questions![index].option);
}

Future<TestModel> addNewQuestion(TestModel test, int index) async {
  test.questions!.add(QuestionModel());
  final CollectionReference db = FirebaseFirestore.instance
      .collection('QuizList')
      .doc(test.quizId)
      .collection('Questions');
  var id = await db.add(test.questions![index].toMap()).then((doc) => doc.id);
  // print('qid: $id');
  test.questions![index].qid = id;
  await db.doc(id).set({"qid": id, 'createdAt': Timestamp.now()});
  return test;
}

deleteExisitingQuestion(TestModel test, int index) async {
  final CollectionReference db = FirebaseFirestore.instance
      .collection('QuizList')
      .doc(test.quizId)
      .collection('Questions');
  await db.doc(test.questions![index].qid).delete();
}
