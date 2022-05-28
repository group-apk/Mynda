import 'package:flutter/material.dart';

import '../model/question_model.dart';
class QuestionCard extends StatefulWidget {
  final Question _question;

  const QuestionCard(this._question);

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 60,
        height: 140,
        child: Card(
          elevation:0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children:[
                Row(
                  children:[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text("${widget._question.question}"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    //_question.option!.forEach((element) => 
                    Text(
                      //element,
                      "fsfsfsefsefwer",
                      style:Theme.of(context).textTheme.headline6
                      ),
                 //   ),
                    Spacer(),
                ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
