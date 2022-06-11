import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:mynda/model/article_model.dart';
import 'package:mynda/provider/article_notifier.dart';
import 'package:mynda/services/api.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ArticleReadingScreen extends StatefulWidget {
  const ArticleReadingScreen({Key? key}) : super(key: key);

  @override
  State<ArticleReadingScreen> createState() => _ArticleReadingScreenState();
}

class _ArticleReadingScreenState extends State<ArticleReadingScreen> {
  String categories = "";
  Future<bool> onLikeButtonTapped(bool isLiked) async {
    ArticleNotifier articleNotifier = Provider.of<ArticleNotifier>(context, listen: false);
    ArticleModel currentArticleModel = articleNotifier.currentArticleModel;
    if (isLiked == false) {
      currentArticleModel.likes = currentArticleModel.likes! + 1;
      updateArticleLikes(currentArticleModel);
      getArticle(articleNotifier);
    } else {
      currentArticleModel.likes = currentArticleModel.likes! - 1;
      updateArticleLikes(currentArticleModel);
      getArticle(articleNotifier);
    }
    return !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    ArticleNotifier articleNotifier = Provider.of<ArticleNotifier>(context, listen: false);
    ArticleModel currentArticleModel = articleNotifier.currentArticleModel;
    for (int i = 0; i < currentArticleModel.category!.length; i++) {
      if (i == currentArticleModel.category!.length - 1) {
        categories += currentArticleModel.category![i];
      } else {
        categories += currentArticleModel.category![i];
        categories += ", ";
      }
    }
    var date = DateFormat('dd MMMM yyyy, hh:mm a').format(currentArticleModel.createdAt!.toDate());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF0069FE),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${currentArticleModel.title}",
                      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.8))),
                  Text("by ${currentArticleModel.author} ($date)", style: const TextStyle(color: Colors.grey, fontSize: 18)),
                  Text("Categories: $categories", style: const TextStyle(color: Colors.grey, fontSize: 18)),
                  const SizedBox(height: 12),
                  Image.network(
                    '${currentArticleModel.imgurl}',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                  ),
                  const SizedBox(height: 12),
                  for (int i = 0; i < currentArticleModel.body!.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text("\t ${currentArticleModel.body![i]}", style: const TextStyle(fontSize: 18)),
                    ),
                  const SizedBox(height: 12),
                  LikeButton(
                    mainAxisAlignment: MainAxisAlignment.start,
                    likeCount: currentArticleModel.likes,
                    onTap: onLikeButtonTapped,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
