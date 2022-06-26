// ignore_for_file: unused_import

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mynda/provider/article_notifier.dart';
import 'package:mynda/services/api.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:provider/provider.dart';
import '../test_staff/statistic_test.dart';
import '../test_staff/article_chart.dart';
import 'add_article.dart';
import 'article_edit.dart';


class ArticleListScreen extends StatefulWidget {
  const ArticleListScreen({Key? key}) : super(key: key);

  @override
  State<ArticleListScreen> createState() => _ArticleListScreen();
}

class _ArticleListScreen extends State<ArticleListScreen> {
  int i = 0;
  //var options = Options(format: Format.hex, colorType: ColorType.blue);
  var options = Options(
      format: Format.hsl,
      count: 100,
      colorType: ColorType.blue,
      luminosity: Luminosity.light);

  @override
  void initState() {
    ArticleNotifier articleNotifier =
        Provider.of<ArticleNotifier>(context, listen: false);
    getArticle(articleNotifier);
    super.initState();
  }

  int checkArticleTitle(String title) {
    int index = 0;
    ArticleNotifier articleNotifier =
        Provider.of<ArticleNotifier>(context, listen: false);
    for (int i = 0; i < articleNotifier.articleList.length; i++) {
      if (title == articleNotifier.articleList[i].title) {
        index = i;
      }
    }
    return index;
  }

  @override
  Widget build(BuildContext context) {
    ArticleNotifier articleNotifier =
        Provider.of<ArticleNotifier>(context, listen: false);
    Widget body = WillPopScope(
      onWillPop: (() async => false),
      child: Scaffold(
        floatingActionButton:
        
        SpeedDial(
          icon: Icons.list,
          backgroundColor: Color.fromARGB(255, 43, 112, 240),
          children: [
            SpeedDialChild(
              child: const Icon(Icons.add),
              label: 'Add Article',
              backgroundColor: Color.fromARGB(255, 116, 234, 255),
              onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddArticleScreen()));
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.stacked_bar_chart),
              label: 'Likes Statistic',
              backgroundColor: Color.fromARGB(255, 116, 234, 255),
              onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ArticleChart()));
              },
            ),
            
          ]),
        

        
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Article Manager'),
          titleTextStyle: const TextStyle(
              color: Colors.blue, fontSize: 20.0, fontWeight: FontWeight.bold),
          elevation: 2,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: FutureBuilder(
              future: getArticleFuture(articleNotifier),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Consumer<ArticleNotifier>(
                  builder: (context, value, child) => GridView.count(
                    shrinkWrap: true,
                    primary: false,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 1,
                    childAspectRatio: (1 / 0.4),
                    children: articleNotifier.articleList
                        .map((e) => InkWell(
                              onTap: () {
                                articleNotifier.currentArticleModel =
                                    articleNotifier.articleList[
                                        checkArticleTitle(e.title as String)];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditArticleScreen(
                                            title: e.title as String)));
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                height: 150,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Stack(
                                    children: [
                                      Container(
                                      color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                                      //color: RandomColor.getColor(options),
                                      width: MediaQuery.of(context).size.width,
                                      height: 250,
                                      ),
                                      Container(
                                        color: Colors.black26,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                e.title as String,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                'by ${e.author}',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );

    return body;
  }
}
