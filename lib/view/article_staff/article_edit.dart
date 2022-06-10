import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mynda/model/test_model.dart';
import 'package:mynda/provider/test_notifier.dart';
import 'package:mynda/services/api.dart';
import 'package:mynda/view/test_staff/question_edit.dart';
import 'package:mynda/view/test_staff/test_category_screen.dart';
import 'package:provider/provider.dart';

class EditArticleScreen extends StatefulWidget {
  const EditArticleScreen({Key? key, this.title = ''}) : super(key: key);
  final String title;

  @override
  State<EditArticleScreen> createState() => _EditArticleScreenState();
}

class _EditArticleScreenState extends State<EditArticleScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Article Edit'),
        titleTextStyle: const TextStyle(
            color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.bold),
        elevation: 2,
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
      body: Text("cubaan")
    );
  }
}
