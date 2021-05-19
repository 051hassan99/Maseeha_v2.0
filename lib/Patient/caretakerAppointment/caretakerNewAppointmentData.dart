import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CaretakerNewAppointmentData extends ChangeNotifier {
  String name;
  int age;
  String gender;
  String diseaseDescription;
  String phonenumber;
  String caretakerName;
  String caretakerEmail;
  String patientEmail;

  CaretakerNewAppointmentData(
      {this.name,
      this.age,
      this.gender,
      this.diseaseDescription,
      this.caretakerName,
      this.caretakerEmail,
      this.patientEmail,
      this.phonenumber});

  factory CaretakerNewAppointmentData.fromJson(Map<String, dynamic> map) {
    return CaretakerNewAppointmentData(
      name: map['PatientName'],
      age: map['Age'],
      gender: map['Gender'],
      diseaseDescription: map['DiseaseDescription'],
      caretakerName: map['CaretakerName'],
      caretakerEmail: map['CaretakerEmail'],
      patientEmail: map['PatientEmail'],
      phonenumber: map['PhoneNumber']
    );
  }

  Map<String, dynamic> get toJson => {
        "PatientName": this.name,
        "PatientEmail":this.patientEmail,
        "Age": this.age,
        "Gender": this.gender,
        "DiseaseDescription": this.diseaseDescription,
        "PhoneNumber": this.phonenumber,
        "CaretakerName": this.caretakerName,
        "CaretakerEmail":this.caretakerEmail,
        "createdAt": FieldValue.serverTimestamp()
      };

  void genderChanged(String value) {
    gender = value;
    notifyListeners();
  }
}
