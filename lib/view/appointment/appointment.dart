import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mynda/model/appointment_model.dart';
import 'package:mynda/provider/appointment_provider.dart';
import 'package:mynda/provider/user_provider.dart';
import 'package:mynda/services/api.dart';
import 'package:mynda/view/appointment/add_guest_appointment.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  ValueNotifier<List<AppointmentModel>>? _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  Map<DateTime, List<AppointmentModel>> events = {
    DateTime.utc(2022, 6, 17, 0, 0, 0, 0, 0): [
      AppointmentModel(
        category: ['Booyah'],
        description: ['weewee'],
      ),
      AppointmentModel(
        category: ['Booyah'],
        description: ['weewee'],
      ),
      AppointmentModel(
        category: ['Booyah'],
        description: ['weewee'],
      ),
      AppointmentModel(
        category: ['Booyah'],
        description: ['weewee'],
      ),
    ],
  };

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  List<AppointmentModel> _getEventsForDay(DateTime day) {
    // Implementation example
    return events[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents!.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final navigator = Navigator.of(context);
    final appointmentProvider = context.read<AppointmentProvider>();
    final userProvider = context.read<UserProvider>();

    Widget body = Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: getAppointments(userProvider, appointmentProvider).then((value) {
              events.addAll(Map.fromIterable(appointmentProvider.getAppointmentList.map(
                (e) {
                  print({e.appointmentAt!.toDate().toUtc(): e});
                  return {e.appointmentAt!.toDate(): e};
                },
              )));
            }),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              print(events);
              return SingleChildScrollView(
                child: Card(
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
                              child: TableCalendar<AppointmentModel>(
                                availableCalendarFormats: const {CalendarFormat.month: 'Month'},
                                firstDay: DateTime(2005),
                                lastDay: DateTime(2055),
                                focusedDay: _focusedDay,
                                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                                rangeStartDay: _rangeStart,
                                rangeEndDay: _rangeEnd,
                                calendarFormat: _calendarFormat,
                                rangeSelectionMode: _rangeSelectionMode,
                                eventLoader: _getEventsForDay,
                                startingDayOfWeek: StartingDayOfWeek.monday,
                                calendarStyle: const CalendarStyle(
                                  // Use `CalendarStyle` to customize the UI
                                  outsideDaysVisible: false,
                                ),
                                onDaySelected: _onDaySelected,
                                onFormatChanged: (format) {
                                  if (_calendarFormat != format) {
                                    setState(() {
                                      _calendarFormat = format;
                                    });
                                  }
                                },
                                onPageChanged: (focusedDay) {
                                  _focusedDay = focusedDay;
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: ValueListenableBuilder<List<AppointmentModel>>(
                            valueListenable: _selectedEvents as ValueNotifier<List<AppointmentModel>>,
                            builder: (context, value, _) {
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: value.length,
                                itemBuilder: (context, index) {
                                  Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                                      child: Container(
                                        color: Colors.blue,
                                        child: Text(
                                          '$value[index]',
                                          style: GoogleFonts.robotoCondensed(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ));

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                    child: Card(
                                      margin: EdgeInsets.zero,
                                      color: Colors.blue[300],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              '${value[index].description}',
                                              style: GoogleFonts.robotoCondensed(
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              '${value[index].category}',
                                              style: GoogleFonts.robotoCondensed(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
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
                                        getAppointments(userProvider, appointmentProvider);
                                        showDialog(context: context, builder: (context) => const AddGuestScreen());
                                      },
                                      child: Text(
                                        'NEW GUEST APPOINTMENT',
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
                                        getGuests(userProvider, appointmentProvider);
                                        showDialog(context: context, builder: (context) => const AddGuestScreen());
                                      },
                                      child: Text(
                                        'VIEW GUESTS',
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
              );
            },
          ),
        ),
      ),
    );

    return body;
  }
}
