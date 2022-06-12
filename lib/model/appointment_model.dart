import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  String? staffUID, memberUID, id, type;
  bool? isApproved;
  List<String>? category, description;
  Timestamp? createdAt, appointmentAt;

  AppointmentModel.fromMap(Map<String, dynamic> data) {
    staffUID = data['staffUID'];
    memberUID = data['memberUID'];
    id = data['id'];
    type = data['type'];
    isApproved = data['isApproved'];
    category = List<String>.from(data['category']);
    // category = data['category'].map((e) => '$e').toList<String>();
    // description = data['description'].map((e) => '$e').toList<String>();
    createdAt = data['createdAt'];
    appointmentAt = data['appointmentAt'];
  }

  AppointmentModel({
    this.staffUID,
    this.memberUID,
    this.id,
    this.type,
    this.isApproved,
    this.category,
    this.description,
    this.createdAt,
    this.appointmentAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'staffUID': staffUID,
      'memberUID': memberUID,
      'id': id,
      'type': type,
      'isApproved': isApproved,
      'category': category,
      'description': description,
      'createdAt': createdAt,
      'appointmentAt': appointmentAt,
    };
  }
}
