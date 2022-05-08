class UserModel {
  String? uid,
      email,
      fullName,
      ic,
      gender,
      region,
      states;

  UserModel(
      {this.uid,
      this.email,
      this.fullName,
      this.ic,
      this.gender,
      this.region,
      this.states});

  // receive data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        fullName: map['fullName'],
        ic: map['ic'],
        gender: map['gender'],
        region: map['region'],
        states: map['states']);
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
      'states': states
    };
  }
}
