import 'package:flutter/material.dart';
import '../model/article_model.dart';

class ArticleNotifier with ChangeNotifier {
  List<ArticleModel> _articleList = [];
  ArticleModel? _currentArticleModel;
  int _dashboardArticle = 0;

  List<ArticleModel> get articleList => (_articleList);

  ArticleModel get currentArticleModel => _currentArticleModel!;

  int get dashboardArticle => _dashboardArticle;

  set articleList(List<ArticleModel> articleList) {
    _articleList = articleList;
    notifyListeners();
  }

  set dashboardArticle(int dashboardArticle) {
    _dashboardArticle = dashboardArticle;
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
