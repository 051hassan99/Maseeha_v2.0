import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AppointmentReply extends ChangeNotifier {
  String appointmentReplyMessage;
  String docEmail;
  String docName;
  String patientName;
  String patientEmail;

  AppointmentReply(
      {this.appointmentReplyMessage,
      this.patientName,
      this.patientEmail,
      this.docEmail,
      this.docName});

  factory AppointmentReply.fromJson(Map<String, dynamic> map) {
    return AppointmentReply(
        appointmentReplyMessage: map['ReplyMessage'],
        patientName: map['patientName'],
        patientEmail: map['patientEmail'],
        docName: map['DoctorName'],
        docEmail: map['docEmail']);
  }

  Map<String, dynamic> get toJson => {
        "ReplyMessage": this.appointmentReplyMessage,
        "patientName": this.patientName,
        "patientEmail": this.patientEmail,
        "DoctorName": this.docName,
        "docEmail": this.docEmail,
        "createdAt": FieldValue.serverTimestamp()
      };
}
