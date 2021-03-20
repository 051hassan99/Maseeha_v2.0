import 'package:flutter/cupertino.dart';

class CaretakerNewAppointmentData extends ChangeNotifier {
  String name;
  int age;
  String gender;
  String diseaseDescription;
  String phonenumber;
  String caretakerName;

  CaretakerNewAppointmentData(
      {this.name,
      this.age,
      this.gender,
      this.diseaseDescription,
      this.caretakerName});

  factory CaretakerNewAppointmentData.fromJson(Map<String, dynamic> map) {
    return CaretakerNewAppointmentData(
      name: map['PatientName'],
      age: map['Age'],
      gender: map['Gender'],
      diseaseDescription: map['DiseaseDescription'],
      caretakerName: map['CaretakerName'],
    );
  }

  Map<String, dynamic> get toJson => {
        "PatientName": this.name,
        "Age": this.age,
        "Gender": this.gender,
        "DiseaseDescription": this.diseaseDescription,
        "PhoneNumber": this.phonenumber,
        "CaretakerName": this.caretakerName,
      };

  void genderChanged(String value) {
    gender = value;
    notifyListeners();
  }
}
