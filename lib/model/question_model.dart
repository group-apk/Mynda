class Question{
  List<String>? option;
  String? question;

  Question();

  Map<String, dynamic> toJson() =>{'option':option,'question':question};

  Question.fromSnapshot(snapshot)
    : option=List.from(snapshot.data()['option']),
      question=snapshot.data()['question'];


}