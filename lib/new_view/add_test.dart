import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:map_proj/new_model/test_model.dart';
import 'package:map_proj/new_notifier/test_notifier.dart';
import 'package:map_proj/new_view/test_category_screen.dart';
import 'package:provider/provider.dart';
import 'package:map_proj/new_api/test_api.dart';

class AddTestScreen extends StatefulWidget {
  @override
  State<AddTestScreen> createState() => _AddTestScreenState();
}

class _AddTestScreenState extends State<AddTestScreen> {
  final _formKey = GlobalKey<FormState>();
  final TestModel _currentTestModel = TestModel();
  final testNameEditiingController = TextEditingController();

  Future uploadTest(TestModel _currentTestModel) async {
    TestNotifier testNotifier =
        Provider.of<TestNotifier>(context, listen: false);
    _currentTestModel = await uploadNewTest(_currentTestModel);
    print('_currentTestModel = ${_currentTestModel.quizId}');
    getTest(testNotifier);
  }

  @override
  Widget build(BuildContext context) {
    final testNameField = TextFormField(
      autofocus: false,
      controller: testNameEditiingController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter a test name");
        }
      },
      textInputAction: TextInputAction.done,
      onSaved: (value) {
        testNameEditiingController.text = value!;
      },
      decoration: InputDecoration(labelText: 'Test Name'),
    );

    final saveButton = Material(
      elevation: 5,
      color: Color(0xFF0069FE),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _currentTestModel.quizTitle = testNameEditiingController.text;
            uploadTest(_currentTestModel).then((value) {
              Fluttertoast.showToast(
                  msg: testNameEditiingController.text + " test created");
              Navigator.of(context).pop();
            });
          }
        },
        child: Text(
          "Add New Test",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Add new test'),
        titleTextStyle: TextStyle(
            color: Colors.blue, fontSize: 20.0, fontWeight: FontWeight.bold),
        elevation: 2,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF0069FE),
          ),
          onPressed: () {
            // passing this to root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formKey,
              // autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Create new Health Assessment Test",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 44),
                  testNameField,
                  SizedBox(height: 30),
                  saveButton,
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
