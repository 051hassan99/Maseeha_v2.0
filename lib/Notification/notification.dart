import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:maseeha_update/constants/strings.dart';

class NotificationSend extends ChangeNotifier{

  String senderName;
  String notificationType;
  String tokenID;

  checkUpdate(){
    print("THE SENDER NAME IS $senderName");
    print("THE MESSAGE IS $notificationType");
  }

  Future <void>sendNotifications(tokenID) async {
    final postNotificationURL = "https://fcm.googleapis.com/fcm/send";
    final headers = {
      'content-type': 'application/json',
      'Authorization': SERVER_KEY //// Yahan apni server key put karen
    };
    String _token =
        tokenID; // yahan par wo token aay ga jis ko notification bhejna ha
     print("HERE IS THE RESULT");
     print(_token);

    final body = {
      "to": _token,
      "mutable_content": true,
      "notification": {
        "title": "Message From Maseeha",
        "body":
            "You have a new $notificationType notification from $senderName",
      },
    };
     Uri myUri = Uri.parse(postNotificationURL);
    await http.post(
      myUri,
      headers: headers,
      body: json.encode(body),
      encoding: Encoding.getByName('utf-8'),
    );
  }
}
