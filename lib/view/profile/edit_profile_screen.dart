import 'package:flutter/material.dart';
import 'package:mynda/model/user_model.dart';
import 'package:mynda/provider/user_provider.dart';
import 'package:mynda/services/api.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  List<DropdownMenuItem<String>> genders = [
    const DropdownMenuItem(value: "Male", child: Text("Male")),
    const DropdownMenuItem(value: "Female", child: Text("Female")),
  ];

  List<DropdownMenuItem<String>> regions = [
    const DropdownMenuItem(
        value: "Northern Region", child: Text("Northern Region")),
    const DropdownMenuItem(
        value: "Eastern Region", child: Text("Eastern Region")),
    const DropdownMenuItem(
        value: "Central Region", child: Text("Central Region")),
    const DropdownMenuItem(
        value: "Southern Region", child: Text("Southern Region")),
    const DropdownMenuItem(
        value: "East Malaysia", child: Text("East Malaysia")),
  ];

  List<DropdownMenuItem<String>> northState = [
    const DropdownMenuItem(value: "Perlis", child: Text("Perlis")),
    const DropdownMenuItem(value: "Kedah", child: Text("Kedah")),
    const DropdownMenuItem(value: "Pulau Pinang", child: Text("Pulau Pinang")),
    const DropdownMenuItem(value: "Perak", child: Text("Perak")),
  ];

  List<DropdownMenuItem<String>> eastState = [
    const DropdownMenuItem(value: "Kelantan", child: Text("Kelantan")),
    const DropdownMenuItem(value: "Terengganu", child: Text("Terengganu")),
    const DropdownMenuItem(value: "Pahang", child: Text("Pahang")),
  ];

  List<DropdownMenuItem<String>> centralState = [
    const DropdownMenuItem(value: "Selangor", child: Text("Selangor")),
    const DropdownMenuItem(
        value: "Wilayah Perkeutuan", child: Text("Wilayah Perkeutuan")),
  ];

  List<DropdownMenuItem<String>> southState = [
    const DropdownMenuItem(
        value: "Negeri Sembilan", child: Text("Negeri Sembilan")),
    const DropdownMenuItem(value: "Melaka", child: Text("Melaka")),
    const DropdownMenuItem(value: "Johor", child: Text("Johor")),
  ];

  List<DropdownMenuItem<String>> eastMalaysiaState = [
    const DropdownMenuItem(value: "Sabah", child: Text("Sabah")),
    const DropdownMenuItem(value: "Sarawak", child: Text("Sarawak")),
  ];

  // List<TextEditingController> textControllers = [
  //   TextEditingController(), // Full Name
  //   TextEditingController(), // Gender
  //   TextEditingController(), // Email
  //   TextEditingController(), // Academic
  //   TextEditingController(), // Region
  //   TextEditingController(), // State
  // ];

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserProvider>();
    final navigator = Navigator.of(context);
    final formKey = GlobalKey<FormState>();

    List<TextEditingController> textControllers = [
      TextEditingController(text: '${user.temp.fullName}'), // Full Name
      TextEditingController(text: '${user.temp.gender}'), // Gender
      TextEditingController(text: '${user.temp.email}'), // Email
      TextEditingController(text: '${user.temp.academic}'), // Academic
      TextEditingController(text: '${user.temp.region}'), // Region
      TextEditingController(text: '${user.temp.states}'), // State
    ];

    ValueNotifier<String> region = ValueNotifier(textControllers[4].text);

    List<DropdownMenuItem<String>> curState() {
      List<DropdownMenuItem<String>> state = [];
      switch (textControllers[4].text) {
        case "Northern Region":
          state = northState;
          break;
        case "Eastern Region":
          state = eastState;
          break;
        case "Central Region":
          state = centralState;
          break;
        case "Southern Region":
          state = southState;
          break;
        case "East Malaysia":
          state = eastMalaysiaState;
          break;
      }
      // print(state);
      return state;
    }

    print(user.user.toString());

    Widget textTile(
        {required String attribute,
        required TextEditingController controller,
        required String? Function(String?) validator}) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: Text(attribute)),
          Expanded(
            flex: 2,
            child: TextFormField(
              controller: controller,
              validator: validator,
            ),
          ),
        ],
      );
    }

    Widget updateButton = Center(
      child: MaterialButton(
        color: Colors.blue,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        onPressed: () {
          final updatedUser = UserModel(
            uid: user.user.uid,
            role: user.user.role,
            fullName: textControllers[0].text,
            ic: user.user.ic,
            gender: textControllers[1].text,
            email: textControllers[2].text,
            academic:
                (user.user.role == 'staff') ? textControllers[3].text : '',
            region: textControllers[4].text,
            states: textControllers[5].text,
          );
          updateProfile(context, updatedUser).then((value) {
            print(updatedUser.toString());
            navigator.pop();
          });
        },
        child: const Text('UPDATE'),
      ),
    );

    Widget backButton = Center(
      child: MaterialButton(
        color: Colors.blue,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        onPressed: () {
          navigator.pop();
        },
        child: const Text('BACK'),
      ),
    );

    Widget body = SafeArea(
      child: Card(
        elevation: 10,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'Profile Page',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 30),
                            child: Card(
                              shape: CircleBorder(),
                              elevation: 3,
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Icon(
                                  Icons.person,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    textTile(
                                      attribute: 'Full Name:',
                                      controller: textControllers[0],
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
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Expanded(child: Text('Gender:')),
                                        Expanded(
                                          flex: 2,
                                          child:
                                              DropdownButtonFormField<String>(
                                            items: genders,
                                            value: textControllers[1].text,
                                            onChanged: (String? val) {
                                              textControllers[1].text = val!;
                                            },
                                            validator: (value) => value == null
                                                ? "Select your gender"
                                                : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textTile(
                                      attribute: 'Email:',
                                      controller: textControllers[2],
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return ("Please Enter Your Email");
                                        }
                                        // reg expression for email validation
                                        if (!RegExp(
                                                "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                            .hasMatch(value)) {
                                          return ("Please Enter a valid email");
                                        }
                                        return null;
                                      },
                                    ),
                                    (user.user.role == 'staff')
                                        ? textTile(
                                            attribute: 'Academic:',
                                            controller: textControllers[3],
                                            validator: (value) {
                                              return null;
                                            })
                                        : Container(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Expanded(child: Text('Region:')),
                                        Expanded(
                                          flex: 2,
                                          child: DropdownButtonFormField(
                                            value: textControllers[4].text,
                                            items: regions,
                                            onChanged: (String? val) {
                                              // setState(() {
                                              textControllers[4].text = val!;
                                              region.value =
                                                  textControllers[4].text;
                                              print(textControllers[4].text);
                                              switch (textControllers[4].text) {
                                                case "Northern Region":
                                                  textControllers[5].text =
                                                      northState[0].value!;
                                                  break;
                                                case "Eastern Region":
                                                  textControllers[5].text =
                                                      eastState[0].value!;
                                                  break;
                                                case "Central Region":
                                                  textControllers[5].text =
                                                      centralState[0].value!;
                                                  break;
                                                case "Southern Region":
                                                  textControllers[5].text =
                                                      southState[0].value!;
                                                  break;
                                                case "East Malaysia":
                                                  textControllers[5].text =
                                                      eastMalaysiaState[0]
                                                          .value!;
                                                  break;
                                              }
                                              // });
                                            },
                                            validator: (value) => value == null
                                                ? "Select your region"
                                                : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                    ValueListenableBuilder(
                                        valueListenable: region,
                                        builder: (context, val, child) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const Expanded(
                                                  child: Text('State:')),
                                              Expanded(
                                                flex: 2,
                                                child: DropdownButtonFormField(
                                                  key: ObjectKey(
                                                      textControllers[4]),
                                                  value:
                                                      textControllers[5].text,
                                                  items: curState(),
                                                  onChanged: (String? val) {
                                                    // setState(() {
                                                    textControllers[5].text =
                                                        val!;
                                                    // });
                                                  },
                                                  validator: (value) =>
                                                      value == null
                                                          ? "Select your state"
                                                          : null,
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.start,
                                    //   children: [
                                    //     const Expanded(child: Text('State:')),
                                    //     Expanded(
                                    //       child: DropdownButtonFormField(
                                    //         key: ObjectKey(textControllers[4]),
                                    //         value: textControllers[5].text,
                                    //         items: curState(),
                                    //         onChanged: (String? val) {
                                    //           // setState(() {
                                    //           textControllers[5].text = val!;
                                    //           // });
                                    //         },
                                    //         validator: (value) => value == null
                                    //             ? "Select your state"
                                    //             : null,
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    updateButton,
                                    backButton,
                                  ],
                                ),
                              )),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    if (user.user.role != 'Guest') {
      return WillPopScope(onWillPop: (() async => false), child: body);
    }
    return body;
  }
}
