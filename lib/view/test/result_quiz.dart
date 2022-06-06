import 'package:flutter/material.dart';
import 'package:map_proj/playquiz_view/category_view.dart';
import 'package:map_proj/view/dashboard.dart';

class ResultScreen extends StatefulWidget {
//  final List<String> dropdownValueAnswer = []; //simpan list of answer
  //List<QuestionModel> dropdownValueQuestion=[]; //simpan list of question utk dapatkan option
  const ResultScreen({Key? key, required this.dropdownValueAnswer})
      : super(key: key);
  final List<String> dropdownValueAnswer;
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int score = 0;

  void calcScore() {
    // for(int i=0;i<widget.dropdownValueQuestion!.length;i++)
    // {
    //   for(int j=0;j<widget.dropdownValueQuestion![i].option.length;j++){
    //     if(widget.dropdownValueAnswer[i] as String==widget.dropdownValueQuestion![i].option[j])
    //     {
    //       print(widget.dropdownValueAnswer[i]);
    //     }
    //   }
    // }
    print(widget.dropdownValueAnswer[0]);
    //print(widget.dropdownValueQuestion[0]);
  }

  @override
  Widget build(BuildContext context) {
    calcScore();
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              "Congratulations",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 45.0,
          ),
          Text(
            "You Score is",
            style: TextStyle(color: Colors.white, fontSize: 34.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "${score}",
            style: TextStyle(
              color: Colors.orange,
              fontSize: 85.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 100.0,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoryScreen(),
                  ));
            },
            shape: StadiumBorder(),
            color: Colors.lightGreen,
            padding: EdgeInsets.all(18.0),
            child: Text(
              "Take another assessment",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardMain(),
                  ));
            },
            shape: StadiumBorder(),
            color: Color.fromARGB(255, 21, 48, 96),
            padding: EdgeInsets.all(18.0),
            child: Text(
              "Back to home page",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
