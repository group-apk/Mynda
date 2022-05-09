import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:map_proj/profile_screen.dart';
// ignore_for_file: prefer_const_constructors
// ignore_for_file: avoid_print

import '../model/user_model.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final fullNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  final ICEditingController = new TextEditingController();
  final genderEditingController = new TextEditingController();
  final regionEditingController = new TextEditingController();
  final statesEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // full name field
    final fullNameField = TextFormField(
        autofocus: false,
        controller: fullNameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
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
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
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
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ));

    // password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Please Enter Your Password");
          }
          if (!regex.hasMatch(value)) {
            return ("Please Enter at least 6 Character for Password");
          }
        },
        onSaved: (value) {
          passwordEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
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
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ));

    // IC field
    final ICfield = TextFormField(
        autofocus: false,
        controller: ICEditingController,
        keyboardType: TextInputType.number,
        validator: (value) {
          RegExp regex = new RegExp(r'^[0-9]{12}$');
          if (value!.isEmpty) {
            return ("Please Enter Your IC");
          }
          if (!regex.hasMatch(value)) {
            return ("Please Enter Your IC (12 characters required)");
          }
          return null;
        },
        onSaved: (value) {
          ICEditingController.text = value!;
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(12),
        ],
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.assignment_ind_outlined),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "IC",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ));

    // gender
    String? selectedValue = null;
    final genderField = DropdownButtonFormField(
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.face_retouching_natural),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
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

    // region
    String? selectedValue2 = null;
    final regionField = DropdownButtonFormField(
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.map),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
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
    if (regionEditingController.text == "Northern Region"){
      stateField = stateDropdown(item: northStateItems);
    }
    else if (regionEditingController.text == "Eastern Region"){
      stateField = stateDropdown(item: eastStateItems);
    }
    else if (regionEditingController.text == "Central Region"){
      stateField = stateDropdown(item: centralStateItems);
    }
    else if (regionEditingController.text == "Southern Region"){
      stateField = stateDropdown(item: southernStateItems);
    }
    else if (regionEditingController.text == "East Malaysia"){
      stateField = stateDropdown(item: eastMalaysiaStateItems);
    }
    

    // sign up button
    final signupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xFF0069FE),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: Text(
          "Sign Up",
          textAlign: TextAlign.center,
          style: TextStyle(
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
      body: Center(
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
                      "Sign Up as member",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 44.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 44),
                    fullNameField,
                    SizedBox(height: 15),
                    emailField,
                    SizedBox(height: 15),
                    passwordField,
                    SizedBox(height: 15),
                    confirmPasswordField,
                    SizedBox(height: 15),
                    ICfield,
                    SizedBox(height: 15),
                    genderField,
                    SizedBox(height: 15),
                    regionField,
                    SizedBox(height: 15),
                    stateField,
                    SizedBox(height: 15),
                    signupButton,
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Are you a staff? "),
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             RegistrationScreen()));
                          },
                          child: Text(
                            "Sign Up as staff",
                            style: TextStyle(
                                color: Color(0xFF0069FE),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ],
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
    userModel.ic = ICEditingController.text;
    userModel.gender = genderEditingController.text;
    userModel.region = regionEditingController.text;
    userModel.states = statesEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully! Please Login");

    Navigator.of(context).pop();

    // Navigator.pushAndRemoveUntil(
    //     (context),
    //     MaterialPageRoute(builder: (context) => ProfileScreen()),
    //     (route) => false);

    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => ProfileScreen()));
  }

  String? selectedValue3 = null;
  Widget stateDropdown({required item}){
    return DropdownButtonFormField(
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.location_city),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
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
      DropdownMenuItem(child: Text("Male"), value: "Male"),
      DropdownMenuItem(child: Text("Female"), value: "Female"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get regionItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Northern Region"), value: "Northern Region"),
      DropdownMenuItem(child: Text("Eastern Region"), value: "Eastern Region"),
      DropdownMenuItem(child: Text("Central Region"), value: "Central Region"),
      DropdownMenuItem(
          child: Text("Southern Region"), value: "Southern Region"),
      DropdownMenuItem(child: Text("East Malaysia"), value: "East Malaysia"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get northStateItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Perlis"), value: "Perlis"),
      DropdownMenuItem(child: Text("Kedah"), value: "Kedah"),
      DropdownMenuItem(child: Text("Pulau Pinang"), value: "Pulau Pinang"),
      DropdownMenuItem(child: Text("Perak"), value: "Perak"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get eastStateItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Kelantan"), value: "Kelantan"),
      DropdownMenuItem(child: Text("Terengganu"), value: "Terengganu"),
      DropdownMenuItem(child: Text("Pahang"), value: "Pahang"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get centralStateItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Selangor"), value: "Selangor"),
      DropdownMenuItem(
          child: Text("Wilayah Perkeutuan"), value: "Wilayah Perkeutuan"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get southernStateItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text("Negeri Sembilan"), value: "Negeri Sembilan"),
      DropdownMenuItem(child: Text("Melaka"), value: "Melaka"),
      DropdownMenuItem(child: Text("Johor"), value: "Johor"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get eastMalaysiaStateItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Sabah"), value: "Sabah"),
      DropdownMenuItem(child: Text("Sarawak"), value: "Sarawak"),
    ];
    return menuItems;
  }
}
