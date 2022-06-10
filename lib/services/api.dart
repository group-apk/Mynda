import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/article_model.dart';
import '../model/test_model.dart';
import '../model/question_model.dart';
import '../provider/article_notifier.dart';
import '../provider/test_notifier.dart';

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
  }
}

getTest(TestNotifier testNotifier) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('QuizList').get();
  List<TestModel> testList = snapshot.docs
      .map((e) => TestModel.fromMap(e.data() as Map<String, dynamic>))
      .toList();

  testNotifier.testList = testList;
}

Future getTestFuture(TestNotifier testNotifier) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('QuizList').get();
  List<TestModel> testList = snapshot.docs
      .map((e) => TestModel.fromMap(e.data() as Map<String, dynamic>))
      .toList();

  testNotifier.testList = testList;
}

Future<TestModel> uploadNewTest(TestModel test) async {
  final CollectionReference db =
      FirebaseFirestore.instance.collection('QuizList');
  test.quizId =
      await db.add({'quizTitle': test.quizTitle, 'quizImgurl': test.quizImgurl}).then((doc) => doc.id);
  await db.doc(test.quizId).update({"quizId": test.quizId});
  return test;
}

getArticle(ArticleNotifier articleNotifier) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('Articles').get();
  List<ArticleModel> articleList = snapshot.docs
      .map((e) => ArticleModel.fromMap(e.data() as Map<String, dynamic>))
      .toList();

  articleNotifier.articleList = articleList;
}

Future getArticleFuture(ArticleNotifier articleNotifier) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('Articles').get();
  List<ArticleModel> articleList = snapshot.docs
      .map((e) => ArticleModel.fromMap(e.data() as Map<String, dynamic>))
      .toList();

  articleNotifier.articleList = articleList;
}

Future<ArticleModel> uploadNewArticle(ArticleModel article) async {
  final CollectionReference db =
      FirebaseFirestore.instance.collection('Articles');
  article.id =
      await db.add({'title': article.title, 'author': article.author, 'category':article.category,'imgurl': article.imgurl,'body':article.body, 'createdAt': Timestamp.now(), 'likes': 0}).then((doc) => doc.id);
  await db.doc(article.id).update({"id": article.id});
  return article;
}

updateArticleLikes(ArticleModel article) async{
  final CollectionReference db = FirebaseFirestore.instance.collection('Articles');
  await db.doc(article.id).update({"likes": article.likes});
}

updateExistingTest(TestModel test) async {
  final CollectionReference db =
      FirebaseFirestore.instance.collection('QuizList');
  await db.doc(test.quizId).update({"quizTitle": test.quizTitle});
}

deleteExistingTest(TestModel test) async {
  final CollectionReference db =
      FirebaseFirestore.instance.collection('QuizList');
  await db.doc(test.quizId).delete();
}

updateExistingQuestion(TestModel test, int index) async {
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
}

Future<TestModel> addNewQuestion(TestModel test, int index) async {
  test.questions!.add(QuestionModel());
  final CollectionReference db = FirebaseFirestore.instance
      .collection('QuizList')
      .doc(test.quizId)
      .collection('Questions');
  var id = await db.add(test.questions![index].toMap()).then((doc) => doc.id);
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

Future<TestModel> addNewAnswer(TestModel test, int index) async {
  test.questions![index].option?.add("");
  var newList = test.questions![index].option;
  final CollectionReference db = FirebaseFirestore.instance.collection('QuizList').doc(test.quizId).collection('Questions');
  await db.doc(test.questions![index].qid).update({"option": FieldValue.arrayUnion(newList!)});
  return test;
}

deleteExistingAnswer(TestModel test, int index) async{
  final CollectionReference db = FirebaseFirestore.instance.collection('QuizList').doc(test.quizId).collection('Questions');
  await db.doc(test.questions![index].qid).update({"option": test.questions![index].option});
}