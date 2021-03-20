import 'package:flutter/cupertino.dart';

class NewAppointmentData extends ChangeNotifier {
  String name;
  int age;
  String appointmenttype;
  String gender;
  String diseaseDescription;
  String phonenumber;
  String doctorName;

  NewAppointmentData(
      {this.name,
      this.age,
      this.appointmenttype,
      this.gender,
      this.diseaseDescription,
      this.doctorName});

  factory NewAppointmentData.fromJson(Map<String, dynamic> map) {
    return NewAppointmentData(
      name: map['PatientName'],
      age: map['Age'],
      gender: map['Gender'],
      appointmenttype: map['ApointmentType'],
      diseaseDescription: map['DiseaseDescription'],
      doctorName: map['DoctoroName'],
    );
  }

  Map<String, dynamic> get toJson => {
        "PatientName": this.name,
        "Age": this.age,
        "Gender": this.gender,
        "AppointmentType": this.appointmenttype,
        "DiseaseDescription": this.diseaseDescription,
        "PhoneNumber": this.phonenumber,
        "DoctoroName": this.doctorName,
      };

  void genderChanged(String value) {
    gender = value;
    notifyListeners();
  }

  void apponitmentChanged(String value) {
    appointmenttype = value;
    notifyListeners();
  }
}
