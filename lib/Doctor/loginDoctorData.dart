import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:maseeha_update/current_user.dart';

class LoginDoctorData extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String docEmail;
  String docPassword;
  bool verified;

  bool loading;

  LoginDoctorData() {
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
          .signInWithEmailAndPassword(email: docEmail, password: docPassword)
          .then((_) async {
        final user = auth.currentUser;
        check = isEmailVerified(user);
        notifyListeners();
      });

      final currentDoc = await _firestore
          .collection('doctors')
          .where('email', isEqualTo: docEmail)
          .get();
    } catch (err) {
      print(err.toString());
    }
    print('Email Verified Status After: $check');
    print('Email : $docEmail');
    print('Password: $docPassword');
    toggleLoading();
    return check;
  }
}
