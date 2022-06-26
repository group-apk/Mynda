import 'package:flutter/material.dart';
import '../model/result_model.dart';

class ResultProvider with ChangeNotifier {
  List<ResultModel> _resultList = [];
  ResultModel? _currentResultModel;

  List<ResultModel> get resultList => (_resultList);

  ResultModel get currentResultModel => _currentResultModel!;


  set resultList(List<ResultModel> resultList) {
    _resultList = resultList;
    notifyListeners();
  }

  set currentResultModel(ResultModel resultmodel) {
    _currentResultModel = resultmodel;
    notifyListeners();
  }

  addResult(ResultModel result) {
    _resultList.add(result);
    notifyListeners();
  }
}