import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maseeha_update/Assistants/firestore_assitant.dart';
import '../token.dart';

class CaretakerRegisterData extends ChangeNotifier {
  String careName;
  String careEmail;
  String careHospital;
  String pnc;
  String carePassword;
  String careConfirmPass;
  bool loading;
     String tokenId;
  bool securetext = true;

  final firestoreAssitant = FirestoreAssitant();
  final tokenAssistant = Token();

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


   Map<String, dynamic> get toCaretakerJson => {
        "name": this.careName,
        "pnc": this.pnc,
        "caretakerHospital": this.careHospital,
        "caretakerEmail": this.careEmail
      };
  
    Map<String, dynamic> get toTokenJson =>
      {"userEmailId": this.careEmail, "tokenId": this.tokenId};

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
          .then((_) async{
        try{
           print('Uploading data');
           await firestoreAssitant.sendCaretakerData(this);
          print("Getting Token Id...");
          tokenId = await tokenAssistant.getToken();
          print("Token id is "+tokenId);
          await firestoreAssitant.sendTokenData(this);
       
        }

        catch(e){
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
}
