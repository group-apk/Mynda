import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mynda/model/test_model.dart';
import 'package:mynda/provider/test_notifier.dart';
import 'package:mynda/services/api.dart';
import 'package:provider/provider.dart';

class EditQuestionScreen extends StatefulWidget {
  const EditQuestionScreen({Key? key, required this.index, required this.isAdd})
      : super(key: key);
  final int index;
  final bool isAdd;
  @override
  State<EditQuestionScreen> createState() => _EditQuestionScreenState();
}

class _EditQuestionScreenState extends State<EditQuestionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TestNotifier testNotifier =
        Provider.of<TestNotifier>(context, listen: false);
    TestModel currentTestModel = testNotifier.currentTestModel;

    TextEditingController questionNameEditingController = widget.isAdd
        ? TextEditingController()
        : TextEditingController(
            text: currentTestModel.questions![widget.index].question);

    List<TextEditingController> answerEditingController = [];
    currentTestModel.questions![widget.index].option?.forEach((element) {
      answerEditingController.add(TextEditingController(text: element));
    });

    Future updateQuestion(TestModel currentTestModel) async {
      updateExistingQuestion(currentTestModel, widget.index);
      getTest(testNotifier);
    }

    Future deleteQuestion(TestModel currentTestModel) async {
      deleteExisitingQuestion(currentTestModel, widget.index);
      testNotifier.deleteQuestion(currentTestModel, widget.index);
      getTest(testNotifier);
    }

    Widget testQuestionField(TestModel currentTestModel) {
      return TextFormField(
        autofocus: false,
        decoration: const InputDecoration(labelText: 'Question Name'),
        controller: questionNameEditingController,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        style: const TextStyle(fontSize: 20),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return ("Please enter a question name");
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        onSaved: (value) {
          questionNameEditingController.text = value!;
        },
      );
    }

    Widget testAnswersField(TestModel currentTestModel) {
      return FutureBuilder(
        future: getQuestionFuture(currentTestModel),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return SingleChildScrollView(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:
                  currentTestModel.questions![widget.index].option?.length ?? 0,
              itemBuilder: ((context, i) => TextFormField(
                    // key: _answerKey,
                    autofocus: false,
                    decoration: InputDecoration(
                        labelText: 'Answer ${i + 1}',
                        suffixIcon: widget.isAdd
                            ? IconButton(
                                onPressed: answerEditingController[i].clear,
                                icon: const Icon(Icons.clear))
                            : IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.delete),
                              )),
                    controller: answerEditingController[i],
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return ("Please enter an answer");
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    onSaved: (value) {
                      answerEditingController[i].text = value!;
                    },
                  )),
            ),
          );
        },
      );
    }

    // print(_currentTestModel.questions![widget.index].qid);
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: FloatingActionButton(
                heroTag: 'delete',
                backgroundColor: Colors.red,
                child: const Icon(Icons.delete),
                onPressed: () {
                  deleteQuestion(currentTestModel).then((value) {
                    Fluttertoast.showToast(msg: "Question deleted");
                    Navigator.of(context).pop();
                  });
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FloatingActionButton(
              heroTag: 'save',
              backgroundColor: Colors.green[900],
              child: const Icon(Icons.save),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  currentTestModel.questions![widget.index].question =
                      questionNameEditingController.text;
                  for (int i = 0; i < answerEditingController.length; i++) {
                    currentTestModel.questions![widget.index].option![i] =
                        answerEditingController[i].text;
                  }
                  updateQuestion(currentTestModel).then((value) {
                    Fluttertoast.showToast(msg: "Question updated");
                    Navigator.of(context).pop();
                  });
                }
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Question Edit'),
        titleTextStyle: const TextStyle(
            color: Colors.blue, fontSize: 20.0, fontWeight: FontWeight.bold),
        elevation: 2,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF0069FE),
          ),
          onPressed: () {
            widget.isAdd
                ? deleteQuestion(currentTestModel).then((value) {
                    Fluttertoast.showToast(msg: "Question Add cancelled");
                    Navigator.of(context).pop();
                  })
                : Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      widget.isAdd ? "Add new question" : "Question Editor",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    testQuestionField(currentTestModel),
                    const SizedBox(height: 20),
                    testAnswersField(currentTestModel),
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
