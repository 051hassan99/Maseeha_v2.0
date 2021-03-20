import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CaretakerRegisterData extends ChangeNotifier {
  String careName;
  String careEmail;
  String careHospital;
  String pnc;
  String careAddress;
  String carePassword;
  String careConfirmPass;
  bool loading;
  bool securetext = true;

  CaretakerRegisterData() {
    loading = false;
  }

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
        email: careEmail,
        password: carePassword,
      )
          .then((_) {
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
