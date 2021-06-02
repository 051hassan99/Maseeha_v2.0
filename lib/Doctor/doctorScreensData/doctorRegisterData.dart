import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:maseeha_update/Assistants/firestore_assitant.dart';
import 'package:maseeha_update/token.dart';

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
   String tokenId;
  bool securetext = true;
  String result;
  final firestoreAssitant = FirestoreAssitant();
  final tokenAssistant = Token();
  DoctorRegisterData() {
    loading = false;
  }
  Future getData(url) async {
    http.Response response = await http.get(url);
    return response.body;
  }

 

   Map<String, dynamic> get toTokenJson =>
      {"userEmailId": this.docEmail, "tokenId": this.tokenId};

  Map<String, dynamic> get toDoctorJson => {
        "name": this.docName,
        "pmdc": this.pmdc,
        "hospital": this.hospital,
        "specialization": this.specialiozation,
        "docEmail": this.docEmail
      };

  String getCurrentDoctorData() {
    final auth = FirebaseAuth.instance;
    User user = auth.currentUser;
    return user.email;
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
        email: docEmail,
        password: docPassword,
      )
          .then((_) async{
        try {
          print('Uploading data');
          firestoreAssitant.sendDoctorData(this);
        //  print("Getting Token Id...");
         // tokenId = await tokenAssistant.getToken();
         // await firestoreAssitant.sendTokenData(this);
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
   bool isDoctor = false;
    Uri url = Uri.parse(
        'http://192.168.43.35:8000/doctor?pmdc=$pmdc&docName=$docName');
    var data = await getData(url);
    //sleep(const Duration(seconds: 5));
    var decodedData = jsonDecode(data);

    if (decodedData['query'] == 'true') {
      isDoctor = true;
    } else {
      return false;
    }

  
    return isDoctor;
    //print(decodedData['query']);
  }

}
