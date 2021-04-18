import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum UserType {
  Patient,
  Doctor,
  Caretaker,
}

class LoginData extends ChangeNotifier {
  LoginModel loginCredentials;
  bool loading;

  UserType userType;

  String get userTitle {
    assert(userType != null);

    if (userType == UserType.Patient) {
      return 'p';
    } else if (userType == UserType.Doctor) {
      return 'd';
    } else {
      return 'c';
    }
  }

  LoginData() {
    loginCredentials = LoginModel();
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
    final auth = FirebaseAuth.instance;
    bool check = false;

    toggleLoading();
    try {
      await auth
          .signInWithEmailAndPassword(
              email: loginCredentials.email,
              password: loginCredentials.password)
          .then((_) async {
        final user = auth.currentUser;
        check = isEmailVerified(user);
        notifyListeners();
      });
    } catch (err) {
      print(err.toString());
    }
    print('Email Verified Status After: $check');
    print('Email : ${loginCredentials.email}');
    print('Password: ${loginCredentials.password}');
    toggleLoading();
    return check;
  }
}

class LoginModel {
  String email;
  String password;
}
