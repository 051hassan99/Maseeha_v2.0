import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class NewAppointmentData extends ChangeNotifier {
  String name;
  int age;
  String appointmenttype;
  String gender;
  String diseaseDescription;
  String phonenumber;
  String doctorName;
  String docEmail;
  String patientEmail;

  NewAppointmentData(
      {this.name,
      this.age,
      this.appointmenttype,
      this.gender,
      this.diseaseDescription,
      this.doctorName,
      this.patientEmail,
      this.docEmail});

  factory NewAppointmentData.fromJson(Map<String, dynamic> map) {
    return NewAppointmentData(
        name: map['PatientName'],
        age: map['Age'],
        gender: map['Gender'],
        appointmenttype: map['AppointmentType'],
        diseaseDescription: map['DiseaseDescription'],
        patientEmail: map['patientEmail'],
        doctorName: map['DoctorName'],
        docEmail: map['docEmail']);
  }

  Map<String, dynamic> get toJson => {
        "PatientName": this.name,
        "Age": this.age,
        "Gender": this.gender,
        "AppointmentType": this.appointmenttype,
        "DiseaseDescription": this.diseaseDescription,
        "patientEmail": this.patientEmail,
        "DoctorName": this.doctorName,
        "docEmail": this.docEmail,
        "createdAt": FieldValue.serverTimestamp()
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
