import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map_proj/new_model/question_model.dart';
import 'package:map_proj/new_model/test_model.dart';
import 'package:map_proj/new_notifier/test_notifier.dart';

getTest(TestNotifier testNotifier) async{
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('test').get();
  List<TestModel> _testList = snapshot.docs.map((e) =>
    TestModel.fromMap(e.data() as Map<String, dynamic>)
  ).toList();

  testNotifier.testList = _testList;

  _testList = [];
  // print(_testList);
  // print(testNotifier.testList);

  testNotifier.testList.forEach((element) async {
    if(element.id != null){
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('test').doc(element.id).collection('questions').get();
      element.questions = snapshot.docs.map((e) => QuestionModel.fromMap(e.data() as Map<String, dynamic>)).toList();
      
      print(element.id);
      if(element.questions!.isNotEmpty) {
        element.questions!.forEach((e) {
          print(e.question);
          e.answer!.forEach((e) { 
            print(e); 
          });
        });
      }
      // _testList.add(element);
    }
    _testList.add(element);
  });

  testNotifier.testList = _testList;
  // print(testNotifier.testList);
}

// Future getTestFuture(TestNotifier testNotifier) async{
//   await getTest(testNotifier);
// }

uploadNewTest(TestModel test) async{
  final CollectionReference db = FirebaseFirestore.instance.collection('test');
    var id = await db.add(test.toMap()).then((doc) => doc.id);
    print(id);
    await db.doc(id).update({"id": id});
}
