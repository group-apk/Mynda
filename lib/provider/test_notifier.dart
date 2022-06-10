import 'package:flutter/material.dart';
import '../model/test_model.dart';

class TestNotifier with ChangeNotifier {
  List<TestModel> _testList = [];
  TestModel? _currentTestModel;

  List<TestModel> get testList => (_testList);

  TestModel get currentTestModel => _currentTestModel!;

  set testList(List<TestModel> testList) {
    _testList = testList;
    notifyListeners();
  }

  set currentTestModel(TestModel testmodel) {
    _currentTestModel = testmodel;
    notifyListeners();
  }

  addTest(TestModel test) {
    _testList.add(test);
    notifyListeners();
  }

  deleteTest(TestModel test) {
    _testList.removeWhere((element) => element.quizId == test.quizId);
    notifyListeners();
  }

  deleteQuestion(TestModel test, int index) {
    _currentTestModel!.questions!
        .removeWhere((element) => element.qid == test.questions![index].qid);
    notifyListeners();
  }
}
