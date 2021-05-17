
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:maseeha_update/Patient/Custodian/showPatientCustodian.dart';

class LocalNotificationImplement extends ChangeNotifier {
  FlutterLocalNotificationsPlugin fltrNotification;
  String date;
  String time;
  String body;
  

  String completeDateAndTime;
  int val;
  var generalNotificationDetails;
  String title;
  var scheduledTime;

  BuildContext context;

  String getMinutes() {
    String minutes = time[3] + time[4];

    return minutes;
  }

  void timeConvert() {
   
     String newtime = '';
    if (time.contains("PM")) {
      if (time[0] == "1" && time[1] == "2") {
        newtime = "12";
        final minutes = getMinutes();
        newtime = newtime + ":" + minutes;
        time = newtime;

        print("New Time is " + time);
      } else {
        for (int i = 0; i <= 1; i++) {
          newtime += time[i];
        }

        newtime = (int.parse(newtime) + 12).toString();
        final minutes = getMinutes();

        newtime = newtime + ":" + minutes;
        time = newtime;

        print("New Time is " + time);
      }
    } else {
      if (time[0] == "1" && time[1] == "2" && time.contains("AM")) {
        newtime = "00";
        final minutes = getMinutes();
        newtime = newtime + ":" + minutes;
        time = newtime;
       print("New Time is " + time);
      } else {
        for (int i = 0; i <= 4; i++) {
          newtime += time[i];
        }
      time = newtime;
       print("New Time is " + time);
      }
    }
  }


  void mergeTimeAndDate(){


    completeDateAndTime = date+"T"+time;
    scheduledTime = DateTime.parse(completeDateAndTime);

  }

  void intializeSetting() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initializationSettings,
        onSelectNotification: notificationSelected);
  }

  Future showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "Maseeha", "HealthCare", "Local Notification",
        sound:RawResourceAndroidNotificationSound('alarm'),
        playSound: true,
        importance: Importance.max);
    var iSODetails = new IOSNotificationDetails();
    generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iSODetails);

    print("Here is the implementation");
    // ignore: deprecated_member_use
    fltrNotification.schedule(
        1, title, body, scheduledTime, generalNotificationDetails);
  }

  Future notificationSelected(String payload) async {
    print("Notification Selected");
    print(context==null);
  
      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShowPatientCustodian()));
  }
}
