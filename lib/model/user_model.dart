import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid,
      email,
      fullName,
      ic,
      gender,
      region,
      states,
      role,
      academic;

  UserModel(
      {this.uid,
      this.email,
      this.fullName,
      this.ic,
      this.gender,
      this.region,
      this.states,
      this.role,
      this.academic});

  // receive data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        fullName: map['fullName'],
        ic: map['ic'],
        gender: map['gender'],
        region: map['region'],
        states: map['states'],
        role: map['role'],
        academic: map['academic']);
  }

  // sending to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'ic': ic,
      'gender': gender,
      'region': region,
      'states': states,
      'role': role,
      'academic': academic,
    };
  }

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      uid: doc.data().toString().contains('uid') ? doc.get('uid') : '',
      email: doc.data().toString().contains('email') ? doc.get('email') : '',
      fullName:
          doc.data().toString().contains('fullName') ? doc.get('fullName') : '',
      ic: doc.data().toString().contains('ic') ? doc.get('ic') : '',
      gender: doc.data().toString().contains('gender') ? doc.get('gender') : '',
      region: doc.data().toString().contains('region') ? doc.get('region') : '',
      states: doc.data().toString().contains('states') ? doc.get('states') : '',
      role: doc.data().toString().contains('role') ? doc.get('role') : '',
      academic:
          doc.data().toString().contains('academic') ? doc.get('academic') : '',
    );
  }
}
