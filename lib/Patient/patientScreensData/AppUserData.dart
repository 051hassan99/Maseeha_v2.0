import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:maseeha_update/Assistants/firestore_assitant.dart';

import '../../token.dart';

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
  String tokenId;

  AppUserData() {
    loading = false;
  }

  final firestoreAssitant = FirestoreAssitant();
  final tokenAssistant = Token();

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

  Map<String, dynamic> get toTokenJson =>
      {"userEmailId": this.email, "tokenId": this.tokenId};

  void sendVerificationEmail() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    await user.sendEmailVerification();
  }


  Future<void> resetPassword(String email) async {
    final _auth = FirebaseAuth.instance;
    await _auth.sendPasswordResetEmail(email: email);
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
          .then((_) async {
        try {
          print('Uploading data');
          await firestoreAssitant.sendPatientData(this);
          print("Getting Token Id...");
          tokenId = await tokenAssistant.getToken();
          await firestoreAssitant.sendTokenData(this);
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
