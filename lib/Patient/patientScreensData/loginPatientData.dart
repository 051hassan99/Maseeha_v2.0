import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoginPatientData extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  String email;
  String password;
  bool verified;
  bool loading;

  LoginPatientData() {
    loading = false;
  }

  void toggleLoading() {
    loading = !loading;
    notifyListeners();
  }

  String getCurrentPatientData() {
    final auth = FirebaseAuth.instance;
    User user = auth.currentUser;
    return user.email;
  }


  String getCurrentPatientName(){
    final auth = FirebaseAuth.instance;
    User user = auth.currentUser;
    return user.displayName;
  }

  bool isEmailVerified(user) {
    return user.emailVerified;
  }

  Future<bool> signUser() async {
    bool check = false;

    toggleLoading();
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((_) async {
        final user = auth.currentUser;
        check = isEmailVerified(user);
        notifyListeners();
      });
    } catch (err) {
      print(err.toString());
    }
    print('Email Verified Status After: $check');
    print('Email : $email');
    print('Password: $password');
    toggleLoading();
    return check;
  }
}
