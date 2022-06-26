import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mynda/model/appointment_model.dart';
import 'package:mynda/model/guest_model.dart';
import 'package:mynda/model/question_model.dart';
import 'package:mynda/model/test_model.dart';
import 'package:mynda/model/user_model.dart';
import 'package:mynda/provider/appointment_provider.dart';
import 'package:mynda/provider/test_notifier.dart';
import 'package:mynda/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:mynda/model/article_model.dart';
import 'package:mynda/provider/article_notifier.dart';
import "package:collection/collection.dart";

import '../model/result_model.dart';
import '../provider/result_provider.dart';

Future<AppointmentModel> addAppointment({required AppointmentModel appointmentModel}) async {
  await FirebaseFirestore.instance.collection('Appointments').add(appointmentModel.toMap()).then((doc) async {
    appointmentModel.id = doc.id;
    await FirebaseFirestore.instance.collection('Appointments').doc(doc.id).update(appointmentModel.toMap());
    print('Success added appointment');
    print(appointmentModel.memberUID);
    print(appointmentModel.id);
    print(appointmentModel.staffUID);
  });
  return appointmentModel;
}

Future getGuests(UserProvider userProvider, AppointmentProvider appointmentProvider) async {
  await FirebaseFirestore.instance.collection('guests').get().then((snapshot) {
    List<Guest> latestGuests = snapshot.docs.map((e) => Guest.fromMap(e.data())).toList();
    latestGuests.removeWhere((element) => element.staffUID != userProvider.user.uid);
    // print(latestAppointments.toString());
    (latestGuests.isNotEmpty) ? appointmentProvider.setGuests(latestGuests) : null;
    (latestGuests.isNotEmpty) ? print(appointmentProvider.getGuests[0].name) : null;
  });
}

Future<Guest> addGuest({required Guest guest}) async {
  await FirebaseFirestore.instance.collection('guests').add(guest.toMap()).then((doc) async {
    guest.memberUID = doc.id;
    await FirebaseFirestore.instance.collection('guests').doc(doc.id).update(guest.toMap());
    print('Success added guest');
    print(guest.memberUID);
    print(guest.name);
    print(guest.staffUID);
  });
  return guest;
}

Future getAppointments(UserProvider userProvider, AppointmentProvider appointmentProvider) async {
  await FirebaseFirestore.instance.collection('Appointments').get().then((snapshot) {
    List<AppointmentModel> latestAppointments = snapshot.docs.map((e) => AppointmentModel.fromMap(e.data())).toList();
    latestAppointments.removeWhere((element) => element.staffUID != userProvider.user.uid);
    // print(latestAppointments.toString());
    (latestAppointments.isNotEmpty) ? appointmentProvider.setAppointments(latestAppointments) : null;
    (latestAppointments.isNotEmpty) ? print(appointmentProvider.getAppointmentList[0].id) : null;
  });
}

Future updateProfile(BuildContext context, UserModel userModel) async {
  final user = context.read<UserProvider>();
  if (userModel.uid != null) {
    FirebaseFirestore.instance.collection('users').doc(userModel.uid).set(userModel.toMap()).then((value) {
      user.setUpdate = userModel;
    });
  }
}

getQuestion(TestModel testModel) async {
  if (testModel.quizId != null) {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('QuizList').doc(testModel.quizId).collection('Questions').get();
    testModel.questions = snapshot.docs.map((e) => QuestionModel.fromMap(e.data() as Map<String, dynamic>)).toList();
  }
}

Future getQuestionFuture(TestModel testModel) async {
  if (testModel.quizId != null) {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('QuizList').doc(testModel.quizId).collection('Questions').orderBy('createdAt').get();
    testModel.questions = snapshot.docs.map((e) => QuestionModel.fromMap(e.data() as Map<String, dynamic>)).toList();
  }
}

getTest(TestNotifier testNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('QuizList').get();
  List<TestModel> testList = snapshot.docs.map((e) => TestModel.fromMap(e.data() as Map<String, dynamic>)).toList();

  testNotifier.testList = testList;
}

Future getTestFuture(TestNotifier testNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('QuizList').get();
  List<TestModel> testList = snapshot.docs.map((e) => TestModel.fromMap(e.data() as Map<String, dynamic>)).toList();

  testNotifier.testList = testList;
}

Future<TestModel> uploadNewTest(TestModel test) async {
  final CollectionReference db = FirebaseFirestore.instance.collection('QuizList');
  test.quizId = await db.add({'quizTitle': test.quizTitle, 'quizImgurl': test.quizImgurl}).then((doc) => doc.id);
  await db.doc(test.quizId).update({"quizId": test.quizId});
  return test;
}

getArticle(ArticleNotifier articleNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Articles').get();
  List<ArticleModel> articleList = snapshot.docs.map((e) => ArticleModel.fromMap(e.data() as Map<String, dynamic>)).toList();

  articleNotifier.articleList = articleList;
}

Future getArticleFuture(ArticleNotifier articleNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Articles').get();
  List<ArticleModel> articleList = snapshot.docs.map((e) => ArticleModel.fromMap(e.data() as Map<String, dynamic>)).toList();

  articleNotifier.articleList = articleList;
}

Future<ArticleModel> updateCurrentArticle(ArticleModel article) async {
  final CollectionReference db = FirebaseFirestore.instance.collection('Articles');
  await db.doc(article.id).update({
    'title': article.title,
    'author': article.author,
    'category': article.category,
    'imgurl': article.imgurl,
    'body': article.body,
    'createdAt': article.createdAt,
    'likes': article.likes
  });
  return article;
}

Future deleteCurrentArticle(ArticleModel article) async {
  final CollectionReference db = FirebaseFirestore.instance.collection('Articles');
  await db.doc(article.id).delete();
}

Future<ArticleModel> uploadNewArticle(ArticleModel article) async {
  final CollectionReference db = FirebaseFirestore.instance.collection('Articles');
  article.id = await db.add({
    'title': article.title,
    'author': article.author,
    'category': article.category,
    'imgurl': article.imgurl,
    'body': article.body,
    'createdAt': Timestamp.now(),
    'likes': 0
  }).then((doc) => doc.id);
  await db.doc(article.id).update({"id": article.id});
  return article;
}

updateArticleLikes(ArticleModel article) async {
  final CollectionReference db = FirebaseFirestore.instance.collection('Articles');
  await db.doc(article.id).update({"likes": article.likes});
}

updateExistingTest(TestModel test) async {
  final CollectionReference db = FirebaseFirestore.instance.collection('QuizList');
  await db.doc(test.quizId).update({"quizTitle": test.quizTitle});
}

deleteExistingTest(TestModel test) async {
  final CollectionReference db = FirebaseFirestore.instance.collection('QuizList');
  await db.doc(test.quizId).delete();
}

updateExistingQuestion(TestModel test, int index) async {
  final CollectionReference db = FirebaseFirestore.instance.collection('QuizList').doc(test.quizId).collection('Questions');

  await db.doc(test.questions![index].qid).set({
    "createdAt": Timestamp.now(),
    "qid": test.questions![index].qid,
    "question": test.questions![index].question,
    "option": test.questions![index].option
  });
}

Future<TestModel> addNewQuestion(TestModel test, int index) async {
  test.questions!.add(QuestionModel());
  final CollectionReference db = FirebaseFirestore.instance.collection('QuizList').doc(test.quizId).collection('Questions');
  var id = await db.add(test.questions![index].toMap()).then((doc) => doc.id);
  test.questions![index].qid = id;
  await db.doc(id).set({"qid": id, 'createdAt': Timestamp.now()});
  return test;
}

deleteExisitingQuestion(TestModel test, int index) async {
  final CollectionReference db = FirebaseFirestore.instance.collection('QuizList').doc(test.quizId).collection('Questions');
  await db.doc(test.questions![index].qid).delete();
}

Future<TestModel> addNewAnswer(TestModel test, int index) async {
  test.questions![index].option?.add("");
  var newList = test.questions![index].option;
  final CollectionReference db = FirebaseFirestore.instance.collection('QuizList').doc(test.quizId).collection('Questions');
  await db.doc(test.questions![index].qid).update({"option": FieldValue.arrayUnion(newList!)});
  return test;
}

deleteExistingAnswer(TestModel test, int index) async {
  final CollectionReference db = FirebaseFirestore.instance.collection('QuizList').doc(test.quizId).collection('Questions');
  await db.doc(test.questions![index].qid).update({"option": test.questions![index].option});
}

getResult(ResultProvider resultProvider) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('ResultQuiz').get();
  List<ResultModel> resultList = snapshot.docs.map((e) => ResultModel.fromMap(e.data() as Map<String, dynamic>)).toList();

  resultProvider.resultList = resultList;
}

Future getResultFuture(ResultProvider resultProvider) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('ResultQuiz').get();
  List<ResultModel> resultList = snapshot.docs.map((e) => ResultModel.fromMap(e.data() as Map<String, dynamic>)).toList();

  resultProvider.resultList = resultList;

}


Future<ResultModel> uploadNewResult(ResultModel result) async {
  final CollectionReference db = FirebaseFirestore.instance.collection('ResultQuiz');
  result.id = await db.add({
    'marks': result.marks,
    'quizTitle': result.quizTitle,
    'createdAt': Timestamp.now(),
  }).then((doc) => doc.id);
  await db.doc(result.id).update({"id": result.id});
  return result;
}