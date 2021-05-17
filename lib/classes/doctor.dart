import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

enum D { doctorName, email, pmdc, specialization, hospital }

class Doctor extends ChangeNotifier {
  @required
  final int id;
  @required
  final String fullName;
  @required
  final String pmdc;
  @required
  final String hospital;
  @required
  final String specialization;
  @required
  final String docEmail;

  var chatDoctorName = ''; 
    final auth = FirebaseAuth.instance;
      // ignore: deprecated_member_use
  List<String> userList = List<String>(5);
   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Doctor(
      {this.id,
      this.fullName,
      this.pmdc,
      this.hospital,
      this.specialization,
      this.docEmail});

   Future <List> getCurrentUserData()async {
  
   await  firebaseFirestore
        .collection("doctors")
        .where("docEmail", isEqualTo: auth.currentUser.email)
        .get()
        .then((value) {
      value.docs.forEach((result) {
       
       userList[D.doctorName.index] = result["name"];
        userList[D.email.index] =   result["docEmail"];
        userList[D.pmdc.index] = result["pmdc"];
        userList[D.specialization.index] = result["specialization"];
        userList[D.hospital.index] = result["hospital"];

       
      });
    });
    
    return userList;
  }

  factory Doctor.fromJson(Map<String, dynamic> map) {
    return Doctor(
        fullName: map['name'],
        pmdc: map['pmdc'],
        hospital: map['hospital'],
        specialization: map['specialization'],
        docEmail: map['docEmail']);
  }

}
