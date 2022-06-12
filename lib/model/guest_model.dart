class Guest {
  String? staffUID, memberUID, name;

  Guest.fromMap(Map<String, dynamic> data) {
    staffUID = data['staffUID'];
    memberUID = data['memberUID'];
    name = data['name'];
  }

  Guest({
    this.staffUID,
    this.memberUID,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'staffUID': staffUID,
      'memberUID': memberUID,
      'name': name,
    };
  }
}
