import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mynda/view/appointment/add_guest_appointment.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    // final navigator = Navigator.of(context);

    Widget body = SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
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
                            'APPOINTMENTS',
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
                          // margin: const EdgeInsets.all(5),
                          child: TableCalendar(
                            firstDay: DateTime.utc(2010, 10, 16),
                            lastDay: DateTime.utc(2030, 3, 14),
                            focusedDay: DateTime.now(),
                            headerStyle: HeaderStyle(
                              titleTextStyle: GoogleFonts.robotoCondensed(),
                              formatButtonTextStyle: GoogleFonts.robotoCondensed(),
                            ),
                            calendarStyle: CalendarStyle(
                              defaultTextStyle: GoogleFonts.robotoCondensed(),
                              todayTextStyle: GoogleFonts.robotoCondensed(color: Colors.white),
                              holidayTextStyle: GoogleFonts.robotoCondensed(),
                              outsideTextStyle: GoogleFonts.robotoCondensed(),
                              weekendTextStyle: GoogleFonts.robotoCondensed(),
                              disabledTextStyle: GoogleFonts.robotoCondensed(),
                              selectedTextStyle: GoogleFonts.robotoCondensed(),
                            ),
                            calendarFormat: CalendarFormat.month,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10.0, top: 10),
                      child: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              MaterialButton(
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
                                  showDialog(context: context, builder: (context) => const AddGuestScreen());
                                  // navigator.push(
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         const AddGuestScreen(),
                                  //   ),
                                  // );
                                },
                                child: Text(
                                  'NEW GUEST APPOINTMENT',
                                  style: GoogleFonts.robotoCondensed(
                                    color: Colors.white,
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
      ),
    );

    return Scaffold(
      body: body,
    );
  }
}
