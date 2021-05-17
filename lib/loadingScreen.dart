import 'package:flutter/material.dart';
import 'package:maseeha_update/Patient/patientScreens/patient_dashboard.dart';
import 'package:maseeha_update/splashScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Map/userTypeforMap.dart';

class LoadingScreen extends StatelessWidget {

 static const String id = "LoadingScreen";
  void checkUser(BuildContext context) async {

      
    SharedPreferences sp = await SharedPreferences.getInstance();

    bool flag =  sp.getBool("SignedInPatient");
        flag = flag ?? false;
    if (flag ) {

      
        final userType =
        Provider.of<UserType>(context, listen: false);

    
      userType.userType = "Patient";
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PatientDashboard()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
      );
    }
    
  }

  @override
  Widget build(BuildContext context) {

    checkUser(context);    
    return  Scaffold(
          body: Center(
        child: CircularProgressIndicator() ,
        
        ),
    ) ;
  }
}
