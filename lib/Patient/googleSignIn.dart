library maseeha.google_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:maseeha_update/Patient/patientScreens/patient_dashboard.dart';
import 'package:maseeha_update/Patient/patientScreens/patient_login.dart';
import 'package:maseeha_update/Patient/patientScreensData/AppUserData.dart';

_GoogleAuth abc = _GoogleAuth.getInstance();
 enum E { username, email, photoURL }
class _GoogleAuth{
   static _GoogleAuth _instance = new _GoogleAuth();
   final _firebaseAuth = FirebaseAuth.instance;
   final appUserData = AppUserData();

    bool isGoogleLoggedIn = false;

  // ignore: deprecated_member_use
  List<String> userProfileList = List<String>(3);
  static _GoogleAuth getInstance() {
    if (_instance == null) {
      _instance = new _GoogleAuth();
    }
    return _instance;
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<void> signInWithGoogle(BuildContext context) async {

    try{
   
    GoogleSignInAccount googleAccount = await _googleSignIn.signIn();
    if (googleAccount != null) {
      GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
         await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
               idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken));
            
        userProfileList[E.username.index] = _googleSignIn.currentUser.displayName;
        userProfileList[E.email.index] =  _googleSignIn.currentUser.email;
        userProfileList[E.photoURL.index] =  _googleSignIn.currentUser.photoUrl;
        isGoogleLoggedIn = true;
        takeToPatientDashboard(context);

        
      } 
      
      else {
        throw PlatformException(
            code: "Error Missing google auth token",
            message: "Missing google auth token");
      }
    } else {
      throw PlatformException(
          code: "Error Aborted by user", message: "Sign in aborted by user ");
    }
    }
    
      catch (err) {
      print(err);
    }
    }
  

  logout(BuildContext context) async {
    _googleSignIn.signOut();
    isGoogleLoggedIn = false;
    takeToPatientLogIn(context);
  }

  takeToPatientDashboard(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                (userProfileList != null ? PatientDashboard() : () => {})));
  }

  takeToPatientLogIn(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                (userProfileList != null ? PatientLogin() : () => {})));
  }
}







 
