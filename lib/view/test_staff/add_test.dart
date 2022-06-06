import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mynda/model/test_model.dart';
import 'package:mynda/provider/test_notifier.dart';
import 'package:mynda/services/api.dart';
import 'package:provider/provider.dart';

class AddTestScreen extends StatefulWidget {
  const AddTestScreen({Key? key}) : super(key: key);

  @override
  State<AddTestScreen> createState() => _AddTestScreenState();
}

class _AddTestScreenState extends State<AddTestScreen> {
  final _formKey = GlobalKey<FormState>();
  final TestModel _currentTestModel = TestModel();
  final testNameEditiingController = TextEditingController();
  final imageLinkEditingController = TextEditingController();
  // File? file;

  Future uploadTest(TestModel currentTestModel) async {
    TestNotifier testNotifier =
        Provider.of<TestNotifier>(context, listen: false);
    currentTestModel = await uploadNewTest(currentTestModel);
    getTest(testNotifier);
  }

  // Future selectFile() async{
  //   final result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.image);

  //   if (result != null){
  //     file = File(result.files.single.path);
  //   }else{
  //     return;
  //   }
  // }

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
        return null;
      },
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        testNameEditiingController.text = value!;
      },
      decoration: const InputDecoration(labelText: 'Test Name'),
    );

    final imageLinkField = TextFormField(
      autofocus: false,
      controller: imageLinkEditingController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter an image link");
        }
        if(!RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+')
              .hasMatch(value)){
          return ("Not a valid image link");
        }
        return null;
      },
      textInputAction: TextInputAction.done,
      onSaved: (value) {
        imageLinkEditingController.text = value!;
      },
      decoration: const InputDecoration(labelText: 'Image link address'),
    );

  // final selectFileButton = ElevatedButton.icon(
  //     onPressed: () {
  //       selectFile();
  //     },
  //     icon: const Icon(Icons.attach_file, size: 30.0,),
  //     label: const Text("Upload image", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
  //     );

    final saveButton = Material(
      elevation: 5,
      color: const Color(0xFF0069FE),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _currentTestModel.quizTitle = testNameEditiingController.text;
            _currentTestModel.quizImgurl = imageLinkEditingController.text;
            uploadTest(_currentTestModel).then((value) {
              Fluttertoast.showToast(
                  msg: "${testNameEditiingController.text} test created");
              Navigator.of(context).pop();
            });
          }
        },
        child: const Text(
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
        title: const Text('Add new test'),
        titleTextStyle: const TextStyle(
            color: Colors.blue, fontSize: 20.0, fontWeight: FontWeight.bold),
        elevation: 2,
        leading: IconButton(
          icon: const Icon(
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
                  const SizedBox(height: 44),
                  testNameField,
                  const SizedBox(height: 30),
                  // selectFileButton,
                  imageLinkField,
                  const SizedBox(height: 30),
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
