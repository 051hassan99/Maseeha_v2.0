import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

 enum E { patientName, email, address, cnic }

class LoginPatientData extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  String email;
  String password;
  bool verified;
  bool loading;

  // ignore: deprecated_member_use
  List<String> userList = List<String>(4);
   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

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



  bool isEmailVerified(user) {
    return user.emailVerified;
  }


  Future <void> getCurrentUserData()async {
  
   await  firebaseFirestore
        .collection("patients")
        .where("email", isEqualTo: auth.currentUser.email)
        .get()
        .then((value) {
      value.docs.forEach((result) {
       
       userList[E.patientName.index] = result["PatientName"];
        userList[E.email.index] =   result["email"];
        userList[E.address.index] = result["Address"];
        userList[E.cnic.index] = result["CNIC"];

       
      });
    });
    
  }





  Future<bool> signUser() async {
    bool check = false;


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
    return check;
  }
}
