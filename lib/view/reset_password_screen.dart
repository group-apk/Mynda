import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _auth = FirebaseAuth.instance;
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final emailEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ));

    // reset password button
    final resetPasswordButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(3),
      color: const Color(0xFF0069FE),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          resetPasswordFunc(emailEditingController.text);
        },
        child: const Text(
          "Reset Password",
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
          title: const Text('Reset Password'),
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
          child: Center(
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
                        'Please enter your email\nto reset your password.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                        ),
                      ),
                      const SizedBox(height: 20),
                      emailField,
                      const SizedBox(height: 15),
                      resetPasswordButton,
                    ],
                  ),
                ),
              ),
            )),
          ),
        ));
  }

  Future resetPasswordFunc(String email) async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      try {
        await _auth
            .sendPasswordResetEmail(email: email)
            .then((value) => {emailPasswordReset()});
      } catch (e) {
        var err = e.toString();
        Fluttertoast.showToast(msg: err);
        Navigator.of(context, rootNavigator: true).pop();
      }
    }
  }

  emailPasswordReset() async {
    var msg = 'Email sent! Please check your email to reset your password.';
    Fluttertoast.showToast(msg: msg);
    for (var i = 0; i < 2; i++) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
