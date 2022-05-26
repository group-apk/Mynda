import 'package:flutter/material.dart';
import 'package:map_proj/new_api/test_api.dart';
import 'package:map_proj/new_model/test_model.dart';
import 'package:map_proj/new_notifier/test_notifier.dart';
import 'package:provider/provider.dart';

class EditTestScreen extends StatefulWidget {
  const EditTestScreen({Key? key, required this.testName}) : super(key: key);
  final String testName;
  @override
  State<EditTestScreen> createState() => _EditTestScreenState();
}

class _EditTestScreenState extends State<EditTestScreen> {
  final _formKey = GlobalKey<FormState>();

  Widget testNameField(TestModel _currentTestModel) {
    return TextFormField(
      autofocus: false,
      decoration: InputDecoration(labelText: 'Test Name'),
      initialValue: _currentTestModel.testName,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter a test name");
        }
      },
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        _currentTestModel.testName = value;
      },
    );
  }

  Widget questionField(TestModel _currentTestModel) {
    // Text('${_currentTestModel.questions}')
    return FutureBuilder(
      future: getQuestionFuture(_currentTestModel),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        // return Text('${_currentTestModel.questions}');
        return ListView.builder(
          shrinkWrap: true,
          itemCount: _currentTestModel.questions!.length,
          itemBuilder: ((context, i) => ListTile(
                title: Text('${_currentTestModel.questions![i].question}'),
                subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                        // [
                        _currentTestModel.questions![i].answer!
                            .map((e) => Text(e))
                            .toList()),
              )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TestNotifier testNotifier =
        Provider.of<TestNotifier>(context, listen: false);
    TestModel _currentTestModel = testNotifier.currentTestModel;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Test Edit'),
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
                child: Column(
                  children: <Widget>[
                    Text(
                      "Edit ${widget.testName} Test",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    testNameField(_currentTestModel),
                    SizedBox(height: 10),
                    questionField(_currentTestModel),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
