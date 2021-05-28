import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
class CaretakerAppointmentReplyData extends ChangeNotifier{

 String appointmentReplyMessage;
  String caretakerEmail;
  String caretakerName;
  String patientName;
  String patientEmail;

 CaretakerAppointmentReplyData(
      {this.appointmentReplyMessage,
      this.patientName,
      this.patientEmail,
      this.caretakerEmail,
      this.caretakerName});

  factory CaretakerAppointmentReplyData.fromJson(Map<String, dynamic> map) {
    return CaretakerAppointmentReplyData(
        appointmentReplyMessage: map['ReplyMessage'],
        patientName: map['patientName'],
        patientEmail: map['patientEmail'],
        caretakerName: map['CaretakerName'],
        caretakerEmail: map['CaretakerEmail']);
  }

  Map<String, dynamic> get toJson => {
        "ReplyMessage": this.appointmentReplyMessage,
        "patientName": this.patientName,
        "patientEmail": this.patientEmail,
        "CaretakerName": this.caretakerName,
        "CaretakerEmail": this.caretakerEmail,
        "createdAt": FieldValue.serverTimestamp()
      };
}
