class Caretaker {
  String name;
  String pnc;
  String currentStatus;
  int experience;

  Caretaker({this.name, this.pnc, this.currentStatus, this.experience});

  factory Caretaker.fromJson(Map<String, dynamic> map) {
    return Caretaker(
        name: map['name'],
        pnc: map['pnc'],
        currentStatus: map['currentStatus'],
        experience: map['experience']);
  }
}
