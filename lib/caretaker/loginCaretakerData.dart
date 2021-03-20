import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoginCaretakerData extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  String careEmail;
  String carePassword;
  bool verified;

  bool loading;

  LoginCaretakerData() {
    loading = false;
  }

  void toggleLoading() {
    loading = !loading;
    notifyListeners();
  }

  bool isEmailVerified(user) {
    return user.emailVerified;
  }

  Future<bool> signUser() async {
    bool check = false;

    toggleLoading();
    try {
      await auth
          .signInWithEmailAndPassword(email: careEmail, password: carePassword)
          .then((_) async {
        final user = auth.currentUser;
        check = isEmailVerified(user);
        notifyListeners();
      });
    } catch (err) {
      print(err.toString());
    }
    print('Email Verified Status After: $check');
    print('Email : $careEmail');
    print('Password: $carePassword');
    toggleLoading();
    return check;
  }
}
