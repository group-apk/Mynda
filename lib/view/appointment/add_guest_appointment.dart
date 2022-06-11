import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class AddGuestScreen extends StatefulWidget {
  const AddGuestScreen({Key? key}) : super(key: key);

  @override
  State<AddGuestScreen> createState() => _AddGuestScreenState();
}

class _AddGuestScreenState extends State<AddGuestScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final formKey = GlobalKey<FormState>();
    Map<String, TextEditingController> textControllerMap = {
      'Guest Name': TextEditingController(),
      'Title': TextEditingController(),
      'Category': TextEditingController(),
      'Description': TextEditingController(),
      'Date': TextEditingController(
          text:
              '${(selectedDate.day < 10) ? '0${selectedDate.day}' : selectedDate.day}/${(selectedDate.month < 10) ? '0${selectedDate.month}' : selectedDate.month}/${selectedDate.year}'),
    };

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
                                                  firstDate: selectedDate,
                                                  lastDate: selectedDate.add(const Duration(days: 365)),
                                                );
                                                if (picked != null && picked != selectedDate) {
                                                  setState(() {
                                                    selectedDate = picked;
                                                  });
                                                }
                                                // showDialog(
                                                //     context: context,
                                                //     builder: (context) =>
                                                //         DatePickerDialog(
                                                //             initialDate:
                                                //                 selectedDate,
                                                //             firstDate:
                                                //                 DateTime(2021),
                                                //             lastDate: DateTime(
                                                //                 2023)));

                                                // navigator
                                                //     .push(MaterialPageRoute(
                                                //   builder: (context) =>
                                                //       DatePickerDialog(
                                                //     initialDate: DateTime.now(),
                                                //     firstDate: DateTime(2021),
                                                //     lastDate: DateTime(2023),
                                                //   ),
                                                // ));
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
                                          break;
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
                                ]
                                    //     textControllerMap.entries.map<Widget>((e) {
                                    //   EdgeInsetsGeometry padding =
                                    //       const EdgeInsets.symmetric(
                                    //           horizontal: 20, vertical: 15);

                                    //   // if (e.key == 'Description') {
                                    //   //   padding = const EdgeInsets.symmetric(
                                    //   //       horizontal: 20, vertical: 40);
                                    //   // }
                                    //   return Padding(
                                    //     padding: const EdgeInsets.symmetric(
                                    //       horizontal: 20,
                                    //       vertical: 10,
                                    //     ),
                                    //     child: TextFormField(
                                    //       textAlignVertical: TextAlignVertical.top,
                                    //       maxLines: null,
                                    //       textAlign: TextAlign.center,
                                    //       controller: e.value,
                                    //       validator: (String? value) {
                                    //         if (value!.isEmpty) {
                                    //           return '${e.key} must be filled!';
                                    //         }
                                    //         return null;
                                    //       },
                                    //       decoration: InputDecoration(
                                    //         contentPadding: padding,
                                    //         hintText: e.key,
                                    //         border: OutlineInputBorder(
                                    //           borderRadius:
                                    //               BorderRadius.circular(10),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   );
                                    // }).toList(),
                                    ),
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
                                        navigator.pop();
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

    return body;
  }
}
