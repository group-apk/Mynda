import 'package:flutter/material.dart';
import 'package:mynda/model/article_model.dart';
import 'package:mynda/provider/article_notifier.dart';
import 'package:provider/provider.dart';

class ArticleReadingScreen extends StatefulWidget {
  const ArticleReadingScreen({Key? key}) : super(key: key);

  @override
  State<ArticleReadingScreen> createState() => _ArticleReadingScreenState();
}

class _ArticleReadingScreenState extends State<ArticleReadingScreen> {
  @override
  Widget build(BuildContext context) {
    ArticleNotifier articleNotifier = Provider.of<ArticleNotifier>(context, listen: false);
    ArticleModel currentArticleModel = articleNotifier.currentArticleModel;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Article by ${currentArticleModel.author}'),
        titleTextStyle: const TextStyle(
          color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.bold
        ),
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
              padding: const EdgeInsets.all(8.0),
              
            ),
          ),
        ),
      ),
    );
  }
}