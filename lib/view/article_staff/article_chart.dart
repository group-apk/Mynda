// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mynda/model/result_model.dart';
import 'package:mynda/provider/article_notifier.dart';
import 'package:provider/provider.dart';
import 'package:mynda/provider/result_provider.dart';
import 'package:mynda/services/api.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../model/article_model.dart';

class ArticleChart extends StatefulWidget {
  const ArticleChart({Key? key}) : super(key: key);

  @override
  State<ArticleChart> createState() => _ArticleChartState();
}

class _ArticleChartState extends State<ArticleChart> {

  late List<charts.Series<ArticleModel, String>> _seriesBarData;
  late List<ArticleModel> mydata;

    @override
  void initState() {
    ArticleNotifier articleNotifier=
        Provider.of<ArticleNotifier>(context, listen: false);
    getArticle(articleNotifier);
    super.initState();
  }

  _generateData(mydata){
    _seriesBarData= <charts.Series<ArticleModel,String>>[];
    _seriesBarData.add(
      charts.Series(
        domainFn: (ArticleModel article, _)=>article.title.toString(),
        measureFn: (ArticleModel article, _)=>article.likes,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        id: 'Article Likes',
        data:mydata,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Statistic Article Likes'),
          titleTextStyle: const TextStyle(
              color: Colors.blue, fontSize: 20.0, fontWeight: FontWeight.bold),
          elevation: 2,
          automaticallyImplyLeading: false,
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
        body: _buildBody(context),
    );
    
  }

   Widget _buildBody(BuildContext context) {
        ArticleNotifier articleNotifier =
        Provider.of<ArticleNotifier>(context, listen: false);
    return FutureBuilder(
      future: getArticleFuture(articleNotifier),
      builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return _buildChart(context, articleNotifier.articleList);
              }),
    );
  }


 Widget _buildChart(BuildContext context, List<ArticleModel> articledata) {
    mydata = articledata;
    _generateData(mydata);
      return Scaffold(
      body: Center(
        child: Container(
          height: 500,
          child: charts.BarChart(
            _seriesBarData,
            animate: true,
          ),
        ),
      ),
    );

    /*
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Marks by Test',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.0,
              ),
              Expanded(
                child: charts.BarChart(_seriesBarData,
                    animate: true,
                    animationDuration: Duration(seconds:1),
                     behaviors: [
                      new charts.DatumLegend(
                        entryTextStyle: charts.TextStyleSpec(
                            color: charts.MaterialPalette.purple.shadeDefault,
                            fontFamily: 'Georgia',
                            fontSize: 18),
                      )
                    ],
                  ),
              ),
            ],
          ),
        ),
      ),
    );*/
  }
  
   /*Widget _buildChart(BuildContext context, List<ResultModel> resultdata) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bar Chart"),
      ),
      body: Center(
        child: Container(
          height: 300,
          child: charts.BarChart(
            _seriesBarData,
            animate: true,
          ),
        ),
      ),
    );
  }*/






}