import 'package:flutter/material.dart';
import '../core/services/database.dart';
import '../view/add_question.dart';
import '../widgets/widget.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({Key? key}) : super(key: key);

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  DatabaseService databaseService = DatabaseService(uid: '');
  final _formKey = GlobalKey<FormState>();

  late String quizImgUrl, quizTitle, quizDesc;

  bool isLoading = false;
  late String quizId;

  createQuiz() {
    quizId = randomAlphaNumeric(16);
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      Map<String, String> quizData = {"quizImgUrl": quizImgUrl, "quizTitle": quizTitle, "quizDesc": quizDesc};

      databaseService.addQuizData(quizData, quizId).then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddQuestion(quizId)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black54,
        ),
        title: const AppLogo(),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextFormField(
                validator: (val) => val!.isEmpty ? "Enter Quiz Image Url" : null,
                decoration: const InputDecoration(hintText: "Quiz Image Url (Optional)"),
                onChanged: (val) {
                  quizImgUrl = val;
                },
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                validator: (val) => val!.isEmpty ? "Enter Quiz Title" : null,
                decoration: const InputDecoration(hintText: "Quiz Title"),
                onChanged: (val) {
                  quizTitle = val;
                },
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                validator: (val) => val!.isEmpty ? "Enter Quiz Description" : null,
                decoration: const InputDecoration(hintText: "Quiz Description"),
                onChanged: (val) {
                  quizDesc = val;
                },
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  createQuiz();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(30)),
                  child: const Text(
                    "Create Quiz",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
