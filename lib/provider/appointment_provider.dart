import 'package:flutter/material.dart';
import 'package:mynda/model/appointment_model.dart';
import 'package:mynda/model/guest_model.dart';

class AppointmentProvider extends ChangeNotifier {
  List<AppointmentModel> appointments = [];
  List<Guest> guests = [];

  setAppointments(List<AppointmentModel> appointments) {
    this.appointments = appointments;
    notifyListeners();
  }

  List<AppointmentModel> get getAppointmentList => appointments;

  setGuests(List<Guest> guests) {
    this.guests = guests;
    notifyListeners();
  }

  List<Guest> get getGuests => guests;
}
