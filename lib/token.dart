import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class Token extends ChangeNotifier {

  String tokenId;
  String targetUserEmail;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  

  checkUser() {
    print("Target User Email is $targetUserEmail");
  }


  Future<String> getToken() async {
    String token = await FirebaseMessaging.instance.getToken();

    return token;
  }

  Future <String> getTokenId()async {
  
   await  firebaseFirestore
        .collection("tokens")
        .where("userEmailId", isEqualTo: targetUserEmail)
        .get()
        .then((value) {
      value.docs.forEach((result) {
       
        tokenId = (result['tokenId']);

       
      });
    });
    
    return tokenId;
  }
}
