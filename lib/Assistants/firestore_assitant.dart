import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maseeha_update/Custodian/addMedicineData.dart';
import 'package:maseeha_update/Doctor/appointmentReply/appointmentReply.dart';
import 'package:maseeha_update/Doctor/doctorRegisterData.dart';
import 'package:maseeha_update/Patient/AppUserData.dart';
import 'package:maseeha_update/Patient/caretakerAppointment/caretakerNewAppointmentData.dart';
import 'package:maseeha_update/Patient/newAppointmentdata.dart';

class FirestoreAssitant {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> sendAppointment(NewAppointmentData data) async {
    Map<String, dynamic> appointmentData = data.toJson;

    await firebaseFirestore.collection('appointments').add(appointmentData);
  }

  Future<void> sendCaretakerAppointment(
      CaretakerNewAppointmentData data) async {
    Map<String, dynamic> caretakerAppointmentData = data.toJson;

    await firebaseFirestore
        .collection('caretakerAppointments')
        .add(caretakerAppointmentData);
  }

  // Sending Patient Data into Database

  Future<void> sendPatientData(AppUserData data) async {
    Map<String, dynamic> patientData = data.toPatientJson;

    await firebaseFirestore.collection('patients').add(patientData);
  }

  // Sending Doctor Data into Database

  Future<void> sendDoctorData(DoctorRegisterData data) async {
    Map<String, dynamic> doctorData = data.toDoctorJson;

    await firebaseFirestore.collection('doctors').add(doctorData);
  }

  Future<void> sendMedicineData(AddMedicineData data) async {
    Map<String, dynamic> medicineData = data.toMedicineJson;

    await firebaseFirestore.collection('medicines').add(medicineData);
  }

  Future<void> sendApointmentReply(AppointmentReply data) async {
    Map<String, dynamic> replyData = data.toJson;

    await firebaseFirestore.collection('appointmentReply').add(replyData);
  }

  Future<List<NewAppointmentData>> getAppointments(String doctorName) async {
    var appointments = await firebaseFirestore
        .collection('appointments')
        .where('doctorName', isEqualTo: doctorName)
        .get();

    List<NewAppointmentData> apps = [];

    for (var appointment in appointments.docs) {
      apps.add(NewAppointmentData.fromJson(appointment.data()));
    }

    return apps;
  }
}
