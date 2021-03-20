import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:maseeha_update/Assistants/firestore_assitant.dart';

class DoctorRegisterData extends ChangeNotifier {
  String docName;
  String docEmail;
  String hospital;
  String pmdc;
  String specialiozation;
  String docAddress;
  String docPassword;
  String docConfirmPass;
  bool loading;
  bool securetext = true;
  String result;
  final firestoreAssitant = FirestoreAssitant();
  DoctorRegisterData() {
    loading = false;
  }
  Future getData(url) async {
    http.Response response = await http.get(url);
    return response.body;
  }

  Map<String, dynamic> get toDoctorJson => {
        "name": this.docName,
        "pmdc": this.pmdc,
        "hospital": this.hospital,
        "specialization": this.specialiozation
      };

  void secureText() {
    securetext = !securetext;
    notifyListeners();
  }

  void toggleLoading() {
    loading = !loading;
    notifyListeners();
  }

  void sendVerificationEmail() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    await user.sendEmailVerification();
  }

  Future<bool> registerUser() async {
    final auth = FirebaseAuth.instance;
    try {
      toggleLoading();
      await auth
          .createUserWithEmailAndPassword(
        email: docEmail,
        password: docPassword,
      )
          .then((_) {
        try {
          print('Uploading data');
          firestoreAssitant.sendDoctorData(this);
        } catch (_) {
          print('Failed to upload');
        }

        sendVerificationEmail();
      });
      toggleLoading();
      return true;
    } catch (err) {
      print(err.toString());
    }
    toggleLoading();
    return false;
  }

  Future<bool> appConnect() async {
    var data =
        await getData('http://10.0.2.2:5000/?pmdc=$pmdc&docName=$docName');
    sleep(const Duration(seconds: 5));
    var decodedData = jsonDecode(data);
    if (decodedData['query'] == 'true') {
      return true;
    } else {
      return false;
    }
    //print(decodedData['query']);
  }
}
