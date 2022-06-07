import 'package:flutter/material.dart';
import '../model/article_model.dart';

class ArticleNotifier with ChangeNotifier {
  List<ArticleModel> _articleList = [];
  ArticleModel? _currentArticleModel;

  List<ArticleModel> get articleList => (_articleList);

  ArticleModel get currentArticleModel => _currentArticleModel!;

  set articleList(List<ArticleModel> articleList) {
    _articleList = articleList;
    notifyListeners();
  }

  set currentArticleModel(ArticleModel articlemodel) {
    _currentArticleModel = articlemodel;
    notifyListeners();
  }

  addArticle(ArticleModel article) {
    _articleList.add(article);
    notifyListeners();
  }

}
