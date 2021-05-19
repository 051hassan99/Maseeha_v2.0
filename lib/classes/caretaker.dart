class Caretaker {
  String name;
  String pnc;
  String currentStatus;
  int experience;
  String caretakerEmail;
  String cnic;

  Caretaker({this.name, this.pnc, this.currentStatus, this.experience, this.caretakerEmail,this.cnic});

  factory Caretaker.fromJson(Map<String, dynamic> map) {
    return Caretaker(
        name: map['name'],
        pnc: map['pnc'],
        currentStatus: map['currentStatus'],
        experience: map['experience'],
        caretakerEmail: map['caretakerEmail'],
        cnic: map["CNIC"]);
  }
}
