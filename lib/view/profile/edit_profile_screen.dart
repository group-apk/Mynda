import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    const DropdownMenuItem(value: "Northern Region", child: Text("Northern Region")),
    const DropdownMenuItem(value: "Eastern Region", child: Text("Eastern Region")),
    const DropdownMenuItem(value: "Central Region", child: Text("Central Region")),
    const DropdownMenuItem(value: "Southern Region", child: Text("Southern Region")),
    const DropdownMenuItem(value: "East Malaysia", child: Text("East Malaysia")),
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
    const DropdownMenuItem(value: "Wilayah Perkeutuan", child: Text("Wilayah Perkeutuan")),
  ];

  List<DropdownMenuItem<String>> southState = [
    const DropdownMenuItem(value: "Negeri Sembilan", child: Text("Negeri Sembilan")),
    const DropdownMenuItem(value: "Melaka", child: Text("Melaka")),
    const DropdownMenuItem(value: "Johor", child: Text("Johor")),
  ];

  List<DropdownMenuItem<String>> eastMalaysiaState = [
    const DropdownMenuItem(value: "Sabah", child: Text("Sabah")),
    const DropdownMenuItem(value: "Sarawak", child: Text("Sarawak")),
  ];

  Widget button({required String title, required void Function()? onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: MaterialButton(
        highlightElevation: 0,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        color: Colors.blue,
        textColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: GoogleFonts.robotoCondensed(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserProvider>();
    final navigator = Navigator.of(context);
    final formKey = GlobalKey<FormState>();

    final Map<String, String> userMap = {
      'Name': '${user.user.fullName}',
      'IC': '${user.user.ic}',
      'Gender': '${user.user.gender}',
      'Role': (user.user.role == 'staff')
          ? 'Staff'
          : (user.user.role == 'member')
              ? 'Member'
              : 'Guest',
      'Email': '${user.user.email}',
      'Academic': '${user.user.academic}',
      'Region': '${user.user.region}',
      'State': '${user.user.states}',
    };

    List<TextEditingController> textControllers = [
      TextEditingController(text: '${user.user.fullName}'), // Full Name
      TextEditingController(text: '${user.user.gender}'), // Gender
      TextEditingController(text: '${user.user.email}'), // Email
      TextEditingController(text: '${user.user.academic}'), // Academic
      TextEditingController(text: '${user.user.region}'), // Region
      TextEditingController(text: '${user.user.states}'), // State
    ];

    // Widget body = SafeArea(
    //   child: Card(
    //     elevation: 10,
    //     margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
    //     child: Column(
    //       children: [
    //         Expanded(
    //           child: Container(
    //             color: Colors.blue,
    //             child: const Center(
    //               child: Text(
    //                 'Profile Page',
    //                 style: TextStyle(color: Colors.white, fontSize: 20),
    //               ),
    //             ),
    //           ),
    //         ),
    //         Expanded(
    //           flex: 9,
    //           child: Column(
    //             children: [
    //               Expanded(
    //                   flex: 3,
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.center,
    //                     children: [
    //                       const Padding(
    //                         padding: EdgeInsets.only(bottom: 30),
    //                         child: Card(
    //                           shape: CircleBorder(),
    //                           elevation: 3,
    //                           child: Padding(
    //                             padding: EdgeInsets.all(15),
    //                             child: Icon(
    //                               Icons.person,
    //                               size: 30,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       Padding(
    //                           padding:
    //                               const EdgeInsets.symmetric(horizontal: 30),
    //                           child: Form(
    //                             key: formKey,
    //                             child: Column(
    //                               children: [
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.start,
    //                                   children: [
    //                                     const Expanded(
    //                                         child: Text('Full Name:')),
    //                                     Expanded(
    //                                       flex: 2,
    //                                       child: TextFormField(
    //                                         controller: textControllers[0],
    //                                         validator: (value) {
    //                                           RegExp regex = RegExp(r'^.{3,}$');
    //                                           if (value!.isEmpty) {
    //                                             return ("Please Enter Your Full Name");
    //                                           }
    //                                           if (!regex.hasMatch(value)) {
    //                                             return ("Please Enter Your Full Name (Min. 3 characters required)");
    //                                           }
    //                                           return null;
    //                                         },
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.start,
    //                                   children: [
    //                                     const Expanded(child: Text('Gender:')),
    //                                     Expanded(
    //                                       flex: 2,
    //                                       child:
    //                                           DropdownButtonFormField<String>(
    //                                         items: genders,
    //                                         value: textControllers[1].text,
    //                                         onChanged: (String? val) {
    //                                           textControllers[1].text = val!;
    //                                         },
    //                                         validator: (value) => value == null
    //                                             ? "Select your gender"
    //                                             : null,
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 textTile(
    //                                   attribute: 'Email:',
    //                                   controller: textControllers[2],
    //                                   validator: (value) {
    //                                     if (value!.isEmpty) {
    //                                       return ("Please Enter Your Email");
    //                                     }
    //                                     // reg expression for email validation
    //                                     if (!RegExp(
    //                                             "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
    //                                         .hasMatch(value)) {
    //                                       return ("Please Enter a valid email");
    //                                     }
    //                                     return null;
    //                                   },
    //                                 ),
    //                                 (user.user.role == 'staff')
    //                                     ? textTile(
    //                                         attribute: 'Academic:',
    //                                         controller: textControllers[3],
    //                                         validator: (value) {
    //                                           return null;
    //                                         })
    //                                     : Container(),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.start,
    //                                   children: [
    //                                     const Expanded(child: Text('Region:')),
    //                                     Expanded(
    //                                       flex: 2,
    //                                       child: DropdownButtonFormField(
    //                                         value: textControllers[4].text,
    //                                         items: regions,
    //                                         onChanged: (String? val) {
    //                                           // setState(() {
    //                                           textControllers[4].text = val!;
    //                                           region.value =
    //                                               textControllers[4].text;
    //                                           print(textControllers[4].text);
    //                                           switch (textControllers[4].text) {
    //                                             case "Northern Region":
    //                                               textControllers[5].text =
    //                                                   northState[0].value!;
    //                                               break;
    //                                             case "Eastern Region":
    //                                               textControllers[5].text =
    //                                                   eastState[0].value!;
    //                                               break;
    //                                             case "Central Region":
    //                                               textControllers[5].text =
    //                                                   centralState[0].value!;
    //                                               break;
    //                                             case "Southern Region":
    //                                               textControllers[5].text =
    //                                                   southState[0].value!;
    //                                               break;
    //                                             case "East Malaysia":
    //                                               textControllers[5].text =
    //                                                   eastMalaysiaState[0]
    //                                                       .value!;
    //                                               break;
    //                                           }
    //                                           // });
    //                                         },
    //                                         validator: (value) => value == null
    //                                             ? "Select your region"
    //                                             : null,
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 ValueListenableBuilder(
    //                                   valueListenable: region,
    //                                   builder: (context, val, child) {
    //                                     return Row(
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment.start,
    //                                       children: [
    //                                         const Expanded(
    //                                             child: Text('State:')),
    //                                         Expanded(
    //                                           flex: 2,
    //                                           child: DropdownButtonFormField(
    //                                             value: textControllers[5].text,
    //                                             items: curState(),
    //                                             onChanged: (String? val) {
    //                                               textControllers[5].text =
    //                                                   val!;
    //                                             },
    //                                             validator: (value) =>
    //                                                 value == null
    //                                                     ? "Select your state"
    //                                                     : null,
    //                                           ),
    //                                         ),
    //                                       ],
    //                                     );
    //                                   },
    //                                 ),
    //                                 // updateButton,
    //                                 // backButton,
    //                               ],
    //                             ),
    //                           )),
    //                     ],
    //                   )),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    MapEntry<String, TextEditingController> nullEntry = MapEntry('', TextEditingController());
    Map<String, TextEditingController> userMapFiltered = userMap.map((key, value) {
      return ((userMap['Role'] != 'staff') && (key == 'Academic') || (key == 'Role') || (key == 'IC'))
          ? nullEntry
          : MapEntry<String, TextEditingController>(key, TextEditingController(text: value));
    });
    userMapFiltered.removeWhere((key, value) => key == nullEntry.key);

    ValueNotifier<String> regionListener = ValueNotifier(userMapFiltered['Region']!.text);

    List<DropdownMenuItem<String>> curState() {
      List<DropdownMenuItem<String>> state = [];
      switch (userMapFiltered['Region']!.text) {
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
      userMapFiltered['State']!.text = state[0].value.toString();

      // print(state);
      return state;
    }

    // userMapFiltered.keys.forEach((element) {
    //   print(element);
    // });

    var decoration = InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );

    Widget body2 = SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            color: Colors.blue[50],
            margin: const EdgeInsets.symmetric(horizontal: 15),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      color: Colors.blue,
                      margin: const EdgeInsets.only(bottom: 5),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          'PROFILE',
                          textScaleFactor: 2,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.robotoCondensed(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: Colors.blue,
                      child: Card(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Form(
                          key: formKey,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: userMapFiltered.keys
                                        .map((e) => Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 20),
                                              child: Text(
                                                e.toString(),
                                                style: GoogleFonts.robotoCondensed(),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: userMapFiltered.entries
                                        .map(
                                          (e) => (e.key == 'Gender')
                                              ? Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                                  child: DropdownButtonFormField(
                                                      value: e.value.text,
                                                      items: genders,
                                                      decoration: decoration,
                                                      validator: (value) => value == null ? "Select your gender" : null,
                                                      onChanged: (String? val) {
                                                        userMapFiltered.update(e.key, (value) => TextEditingController(text: val));
                                                      }),
                                                )
                                              : (e.key == 'Region')
                                                  ? Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                                      child: DropdownButtonFormField(
                                                          value: e.value.text,
                                                          items: regions,
                                                          decoration: decoration,
                                                          validator: (value) => value == null ? "Select your region" : null,
                                                          onChanged: (String? val) {
                                                            userMapFiltered[e.key]!.text = val!;
                                                            userMapFiltered.update(e.key, (value) => TextEditingController(text: val));
                                                            regionListener.value = userMapFiltered[e.key]!.text;
                                                            print(regionListener.value);

                                                            String state = northState[0].value.toString();
                                                            switch (userMapFiltered['Region']!.text) {
                                                              case "Northern Region":
                                                                state = northState[0].value.toString();
                                                                break;
                                                              case "Eastern Region":
                                                                state = eastState[0].value.toString();
                                                                break;
                                                              case "Central Region":
                                                                state = centralState[0].value.toString();
                                                                break;
                                                              case "Southern Region":
                                                                state = southState[0].value.toString();
                                                                break;
                                                              case "East Malaysia":
                                                                state = eastMalaysiaState[0].value.toString();
                                                                break;
                                                            }
                                                            // userMapFiltered['State']!.text = state;
                                                            userMapFiltered.update('State', (value) => TextEditingController(text: state));
                                                          }),
                                                    )
                                                  : (e.key == 'State')
                                                      ? Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 5),
                                                          child: ValueListenableBuilder(
                                                            valueListenable: regionListener,
                                                            builder: (context, val, child) => DropdownButtonFormField(
                                                              value: userMapFiltered['State']!.text,
                                                              items: curState(),
                                                              decoration: decoration,
                                                              onChanged: (String? val) {
                                                                userMapFiltered.update(e.key, (value) => TextEditingController(text: val));
                                                              },
                                                            ),
                                                          ),
                                                        )
                                                      : Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 5),
                                                          child: TextFormField(
                                                            validator: (value) => value == null ? "Please fill in the ${e.key} field" : null,
                                                            initialValue: e.value.text,
                                                            style: GoogleFonts.robotoCondensed(),
                                                            decoration: decoration,
                                                          ),
                                                        ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10.0, top: 10),
                    child: Card(
                      margin: EdgeInsets.zero,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                          button(
                              title: 'UPDATE',
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  final updatedUser = UserModel(
                                    uid: user.user.uid,
                                    role: user.user.role,
                                    fullName: userMapFiltered['Name']!.text,
                                    ic: user.user.ic,
                                    gender: userMapFiltered['Gender']!.text,
                                    email: userMapFiltered['Email']!.text,
                                    academic: (user.user.role == 'staff') ? textControllers[3].text : '',
                                    region: userMapFiltered['Region']!.text,
                                    states: userMapFiltered['State']!.text,
                                  );
                                  // print(updatedUser.toString());
                                  await updateProfile(context, updatedUser).then((value) {
                                    // print(updatedUser.toString());
                                    navigator.pop();
                                  });
                                }
                              }),
                          button(
                            title: 'BACK',
                            onPressed: () {
                              navigator.pop();
                            },
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return body2;
  }
}
