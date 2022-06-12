import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mynda/model/appointment_model.dart';
import 'package:mynda/model/guest_model.dart';
import 'package:mynda/provider/user_provider.dart';
import 'package:mynda/services/api.dart';
import 'package:provider/provider.dart';

class AddGuestScreen extends StatefulWidget {
  const AddGuestScreen({Key? key}) : super(key: key);

  @override
  State<AddGuestScreen> createState() => _AddGuestScreenState();
}

class _AddGuestScreenState extends State<AddGuestScreen> {
  DateTime selectedDate = DateTime.now();

  List<String> keys = [
    'Guest Name',
    'Title',
    'Category',
    'Description',
    'Date',
  ];

  List<TextEditingController> textControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  Map<String, TextEditingController> textControllerMap = {
    'Guest Name': TextEditingController(),
    'Title': TextEditingController(),
    'Category': TextEditingController(),
    'Description': TextEditingController(),
    'Date': TextEditingController()
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textControllerMap['Date'] = TextEditingController(
        text:
            '${(selectedDate.day < 10) ? '0${selectedDate.day}' : selectedDate.day}/${(selectedDate.month < 10) ? '0${selectedDate.month}' : selectedDate.month}/${selectedDate.year}');
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final userProvider = Provider.of<UserProvider>(context);
    final formKey = GlobalKey<FormState>();

    Widget body = SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            // direction: Axis.vertical,
            children: [
              Card(
                color: Colors.blue[50],
                margin: const EdgeInsets.symmetric(horizontal: 15),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
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
                              'GUEST APPOINTMENT',
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
                            child: Form(
                              key: formKey,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Column(children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemCount: textControllerMap.entries.length,
                                    itemBuilder: (context, index) {
                                      EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15);
                                      int maxLines = 1;
                                      int minLines = 1;

                                      switch (textControllerMap.keys.elementAt(index)) {
                                        case 'Category':
                                          break;
                                        case 'Description':
                                          // padding = const EdgeInsets.symmetric(
                                          //     horizontal: 20, vertical: 40);
                                          maxLines = 5;
                                          minLines = 3;
                                          break;
                                        case 'Date':
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 10,
                                            ),
                                            child: MaterialButton(
                                              padding: padding,
                                              color: Colors.blue,
                                              textColor: Colors.white,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                              onPressed: () async {
                                                final DateTime? picked = await showDatePicker(
                                                  context: context,
                                                  initialDate: selectedDate, // Refer step 1
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.now().add(const Duration(days: 365)),
                                                );
                                                if (picked != null && picked != selectedDate) {
                                                  setState(() {
                                                    selectedDate = picked;
                                                  });
                                                }
                                              },
                                              child: Row(
                                                // mainAxisAlignment: MainAxisAlignment.s,
                                                children: [
                                                  const Expanded(child: Icon(Icons.calendar_month)),
                                                  Expanded(
                                                    flex: 7,
                                                    child: Center(child: Text(textControllerMap['Date']!.text)),
                                                  ),
                                                  const Expanded(child: SizedBox())
                                                ],
                                              ),
                                            ),
                                          );
                                      }

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 10,
                                        ),
                                        child: TextFormField(
                                          minLines: minLines,
                                          maxLines: maxLines,
                                          textAlign: TextAlign.center,
                                          controller: textControllerMap[index],
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return '${textControllerMap.keys.elementAt(index)} must be filled!';
                                            }
                                            textControllerMap.update(
                                                textControllerMap.keys.elementAt(index), (val) => TextEditingController(text: value));
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            contentPadding: padding,
                                            hintText: textControllerMap.keys.elementAt(index),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                ]),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10.0, top: 10),
                        child: Card(
                          margin: EdgeInsets.zero,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
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
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        Guest guest = Guest(staffUID: userProvider.user.uid, name: textControllerMap['Guest Name']!.text);
                                        addGuest(guest: guest).then((value) => guest).then((value) {
                                          AppointmentModel article = AppointmentModel(
                                            staffUID: userProvider.user.uid,
                                            memberUID: guest.memberUID,
                                            id: '',
                                            type: 'guest',
                                            isApproved: false,
                                            category: [textControllerMap['Category']!.text],
                                            description: [textControllerMap['Description']!.text],
                                            createdAt: Timestamp.now(),
                                            appointmentAt: Timestamp.fromDate(selectedDate),
                                          );
                                          addAppointment(appointmentModel: article).then((value) {
                                            navigator.pop();
                                          });
                                        });
                                      }
                                    },
                                    child: Text(
                                      'SUBMIT',
                                      style: GoogleFonts.robotoCondensed(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
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
                                    onPressed: () {
                                      navigator.pop();
                                    },
                                    child: Text(
                                      'BACK',
                                      style: GoogleFonts.robotoCondensed(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: body,
    );
  }
}
