import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maseeha_update/Doctor/appointmentReply/appointmentReply.dart';
import 'package:maseeha_update/Doctor/doctorScreensData/doctorRegisterData.dart';
import 'package:maseeha_update/Patient/Custodian/addMedicineData.dart';
import 'package:maseeha_update/Patient/caretakerAppointment/caretakerNewAppointmentData.dart';
import 'package:maseeha_update/Patient/patientScreensData/AppUserData.dart';
import 'package:maseeha_update/Patient/patientScreensData/newAppointmentdata.dart';
import 'package:maseeha_update/caretaker/caretakerAppointmentReplyData.dart';
import 'package:maseeha_update/caretaker/caretakerRegister.dart';



class FirestoreAssitant {

 
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> sendAppointment(NewAppointmentData data) async {
            bool appointmentSent = false;
    try{
    Map<String, dynamic> appointmentData = data.toJson;

    await firebaseFirestore.collection('appointments').add(appointmentData);
                appointmentSent = true;
    }

   catch(e){
           print(e);
   }
          return appointmentSent; 
  }

  Future<void> sendCaretakerAppointment(
      CaretakerNewAppointmentData data) async {
    Map<String, dynamic> caretakerAppointmentData = data.toJson;

    await firebaseFirestore
        .collection('caretakerAppointments')
        .add(caretakerAppointmentData);
  }



  Future<void> sendPatientData(AppUserData data) async {
    Map<String, dynamic> patientData = data.toPatientJson;

    await firebaseFirestore.collection('patients').add(patientData);
  }

  Future<void> sendTokenData(data) async {
    Map<String, dynamic> tokenData = data.toTokenJson;

    await firebaseFirestore.collection('tokens').add(tokenData);
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


  Future<void> sendCaretaklerApointmentReply(CaretakerAppointmentReplyData data) async {
    Map<String, dynamic> replyData = data.toJson;

    await firebaseFirestore.collection('caretakerAppointmentReply').add(replyData);
  }

   Future<void> sendCaretakerData(CaretakerRegisterData data) async {
    Map<String, dynamic> caretakerData = data.toCaretakerJson;

    await firebaseFirestore.collection('caretakers').add(caretakerData);
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
