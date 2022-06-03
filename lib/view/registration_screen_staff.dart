import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mynda/model/user_model.dart';
import 'package:mynda/view/login_screen.dart';

class RegistrationScreenStaff extends StatefulWidget {
  const RegistrationScreenStaff({Key? key}) : super(key: key);

  @override
  State<RegistrationScreenStaff> createState() =>
      _RegistrationScreenStaffState();
}

class _RegistrationScreenStaffState extends State<RegistrationScreenStaff> {
  final _auth = FirebaseAuth.instance;
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final fullNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  final icEditingController = TextEditingController();
  final genderEditingController = TextEditingController();
  final academicEditingController = TextEditingController();
  final regionEditingController = TextEditingController();
  final statesEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // full name field
    final fullNameField = TextFormField(
        autofocus: false,
        controller: fullNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Please Enter Your Full Name");
          }
          if (!regex.hasMatch(value)) {
            return ("Please Enter Your Full Name (Min. 3 characters required)");
          }
          return null;
        },
        onSaved: (value) {
          fullNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Full Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ));

    // email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
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

    // password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Please Enter Your Password");
          }
          if (!regex.hasMatch(value)) {
            return ("Please Enter at least 6 Character for Password");
          }
          return null;
        },
        onSaved: (value) {
          passwordEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ));

    // confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Password don't match";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ));

    // IC field
    final icfield = TextFormField(
        autofocus: false,
        controller: icEditingController,
        keyboardType: TextInputType.number,
        validator: (value) {
          RegExp regex = RegExp(r'^[0-9]{12}$');
          if (value!.isEmpty) {
            return ("Please Enter Your IC");
          }
          if (!regex.hasMatch(value)) {
            return ("Please Enter Your IC (12 characters required)");
          }
          return null;
        },
        onSaved: (value) {
          icEditingController.text = value!;
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(12),
        ],
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.assignment_ind_outlined),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "IC",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ));

    // gender
    String? selectedValue;
    final genderField = DropdownButtonFormField(
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.face_retouching_natural),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Gender",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      value: selectedValue,
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue!;
        });
        genderEditingController.text = selectedValue!;
      },
      validator: (value) => value == null ? "Select your gender" : null,
      items: genderItems,
    );

    // highest academic qualification
    final academicField = TextFormField(
        autofocus: false,
        controller: academicEditingController,
        keyboardType: TextInputType.text,
        validator: (value) {
          RegExp regex = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Please Enter Your Highest Academic Qualification");
          }
          if (!regex.hasMatch(value)) {
            return ("Min. 3 characters required");
          }
          return null;
        },
        onSaved: (value) {
          academicEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.school),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Highest Academic Qualification",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ));

    // region
    String? selectedValue2;
    final regionField = DropdownButtonFormField(
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.map),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Region",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      value: selectedValue2,
      onChanged: (String? newValue) {
        setState(() {
          selectedValue2 = newValue!;
        });
        regionEditingController.text = selectedValue2!;
      },
      validator: (value) => value == null ? "Select your region" : null,
      items: regionItems,
    );

    // states
    var stateField = stateDropdown(item: null);
    if (regionEditingController.text == "Northern Region") {
      stateField = stateDropdown(item: northStateItems);
    } else if (regionEditingController.text == "Eastern Region") {
      stateField = stateDropdown(item: eastStateItems);
    } else if (regionEditingController.text == "Central Region") {
      stateField = stateDropdown(item: centralStateItems);
    } else if (regionEditingController.text == "Southern Region") {
      stateField = stateDropdown(item: southernStateItems);
    } else if (regionEditingController.text == "East Malaysia") {
      stateField = stateDropdown(item: eastMalaysiaStateItems);
    }

    // sign up button
    final signupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: const Color(0xFF0069FE),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: const Text(
          "Sign Up",
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                      // SizedBox(
                      //   // app logo here

                      //   height: 180,
                      //   child: Image.asset(
                      //     "",
                      //     fit: BoxFit.contain,
                      //   ),
                      // ),
                      const Text(
                        "Sign Up as Staff",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 44.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 44),
                      fullNameField,
                      const SizedBox(height: 15),
                      emailField,
                      const SizedBox(height: 15),
                      passwordField,
                      const SizedBox(height: 15),
                      confirmPasswordField,
                      const SizedBox(height: 15),
                      icfield,
                      const SizedBox(height: 15),
                      genderField,
                      const SizedBox(height: 15),
                      academicField,
                      const SizedBox(height: 15),
                      regionField,
                      const SizedBox(height: 15),
                      stateField,
                      const SizedBox(height: 15),
                      signupButton,
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    // calling firestore
    // calling user model
    // sending these value

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // Writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.fullName = fullNameEditingController.text;
    userModel.ic = icEditingController.text;
    userModel.gender = genderEditingController.text;
    userModel.region = regionEditingController.text;
    userModel.states = statesEditingController.text;
    userModel.role = "staff";
    userModel.academic = academicEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully! Please Login");

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  String? selectedValue3;
  Widget stateDropdown({required item}) {
    return DropdownButtonFormField(
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.location_city),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "State",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      value: selectedValue3,
      onChanged: (String? newValue) {
        setState(() {
          selectedValue3 = newValue!;
        });
        statesEditingController.text = selectedValue3!;
      },
      validator: (value) => value == null ? "Select your state" : null,
      items: item,
    );
  }

  List<DropdownMenuItem<String>> get genderItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Male", child: Text("Male")),
      const DropdownMenuItem(value: "Female", child: Text("Female")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get regionItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Northern Region", child: Text("Northern Region")),
      const DropdownMenuItem(
          value: "Eastern Region", child: const Text("Eastern Region")),
      const DropdownMenuItem(
          value: "Central Region", child: Text("Central Region")),
      const DropdownMenuItem(
          value: "Southern Region", child: Text("Southern Region")),
      const DropdownMenuItem(
          value: "East Malaysia", child: const Text("East Malaysia")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get northStateItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Perlis", child: Text("Perlis")),
      const DropdownMenuItem(value: "Kedah", child: Text("Kedah")),
      const DropdownMenuItem(
          value: "Pulau Pinang", child: Text("Pulau Pinang")),
      const DropdownMenuItem(value: "Perak", child: Text("Perak")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get eastStateItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Kelantan", child: Text("Kelantan")),
      const DropdownMenuItem(value: "Terengganu", child: Text("Terengganu")),
      const DropdownMenuItem(value: "Pahang", child: const Text("Pahang")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get centralStateItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Selangor", child: Text("Selangor")),
      const DropdownMenuItem(
          value: "Wilayah Perkeutuan", child: Text("Wilayah Perkeutuan")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get southernStateItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Negeri Sembilan", child: Text("Negeri Sembilan")),
      const DropdownMenuItem(value: "Melaka", child: Text("Melaka")),
      const DropdownMenuItem(value: "Johor", child: Text("Johor")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get eastMalaysiaStateItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Sabah", child: Text("Sabah")),
      const DropdownMenuItem(value: "Sarawak", child: Text("Sarawak")),
    ];
    return menuItems;
  }
}
