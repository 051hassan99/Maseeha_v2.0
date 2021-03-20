import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:maseeha_update/Assistants/firestore_assitant.dart';

class AppUserData extends ChangeNotifier {
  String name;
  String email;
  String address;
  String cnic;
  String password;
  String confirmPass;
  bool loading;
  bool securetext = true;
  bool firstTimeUser = false;

  AppUserData() {
    loading = false;
  }

  final firestoreAssitant = FirestoreAssitant();

  void secureText() {
    securetext = !securetext;
    notifyListeners();
  }

  void toggleLoading() {
    loading = !loading;
    notifyListeners();
  }

  Map<String, dynamic> get toPatientJson => {
        "PatientName": this.name,
        "email": this.email,
        "Address": this.address,
        "CNIC": this.cnic
      };

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
        email: email,
        password: password,
      )
          .then((_) {
        try {
          print('Uploading data');
          firestoreAssitant.sendPatientData(this);
        } catch (_) {
          print('Failed to upload');
        }
        firstTimeUser = true;
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
}
