import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maseeha_update/Patient/googleSignIn.dart' as googleauth;
import 'package:maseeha_update/Patient/patientScreens/patient_login.dart';
import 'package:maseeha_update/Patient/patientScreensData/loginPatientData.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatelessWidget {

  final auth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    
    String name;
    String email;
    String address;
    String cnic;
    


    Future getUserCredentials() async {
      SharedPreferences sp = await SharedPreferences.getInstance();
      name = sp.getString("name");
      email = sp.getString("email");
      address = sp.getString("address");
      cnic = sp.getString("cnic");

      return 'data';
    }



    return Drawer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
        googleauth.abc.isGoogleLoggedIn
            ? Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 120,
                        margin: EdgeInsets.only(
                          top: 30,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(googleauth.abc.userProfileList[
                                        googleauth.E.photoURL.index] !=
                                    null
                                ? googleauth.abc.userProfileList[
                                    googleauth.E.photoURL.index]
                                : 'https://images.unsplash.com/photo-1486312338219-ce68d2c6f44d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=752&q=80'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 10),
                              Text(
                               DemoLocalization.of(context)
                        .getTranslatedValue('Name'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 20),
                              Text(
                                  googleauth.abc.userProfileList[
                                              googleauth.E.username.index] !=
                                          null
                                      ? googleauth.abc.userProfileList[
                                          googleauth.E.username.index]
                                      : 'Mark ZukerBerg',
                                  style: TextStyle(
                                    fontFamily:
                                        'Jameel Noori Nastaleeq Kasheeda',
                                    color: Colors.white,
                                    fontSize: 16,
                                  )),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 10),
                              Text(
                                DemoLocalization.of(context)
                        .getTranslatedValue('Email'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 20),
                              Text(
                                  googleauth.abc.userProfileList[
                                              googleauth.E.email.index] !=
                                          null
                                      ? googleauth.abc.userProfileList[
                                          googleauth.E.email.index]
                                      : 'abc@gmail.com',
                                  style: TextStyle(
                                    fontFamily:
                                        'Jameel Noori Nastaleeq Kasheeda',
                                    color: Colors.white,
                                    fontSize: 16,
                                  )),
                            ]),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                width: double.infinity,
                height: 400,
                padding: EdgeInsets.all(18),
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: 80,
                          height: 120,
                          margin: EdgeInsets.only(
                            top: 50,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://images.unsplash.com/photo-1486312338219-ce68d2c6f44d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=752&q=80'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      FutureBuilder(
                          future: getUserCredentials(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData)
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        DemoLocalization.of(context)
                        .getTranslatedValue('Name'),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              'Jameel Noori Nastaleeq Kasheeda',
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                          name != null
                                              ? name
                                              : 'Mark ZukerBerg',
                                          style: TextStyle(
                                            fontFamily:
                                                'Jameel Noori Nastaleeq Kasheeda',
                                            color: Colors.white,
                                            fontSize: 16,
                                          )),
                                    ]),
                              );
                            else
                              return CircularProgressIndicator();
                          }),
                      FutureBuilder(
                          future: getUserCredentials(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData)
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                       DemoLocalization.of(context)
                        .getTranslatedValue('Email'),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              'Jameel Noori Nastaleeq Kasheeda',
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                          email != null
                                              ? email
                                              : 'abc@gmail.com',
                                          style: TextStyle(
                                            fontFamily:
                                                'Jameel Noori Nastaleeq Kasheeda',
                                            color: Colors.white,
                                            fontSize: 16,
                                          )),
                                    ]),
                              );
                            else
                              return CircularProgressIndicator();
                          }),
                      FutureBuilder(
                          future: getUserCredentials(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData)
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          DemoLocalization.of(context)
                        .getTranslatedValue('Address'),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                                'Jameel Noori Nastaleeq Kasheeda',
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                            address != null
                                                ? address
                                                : 'xxxxxxxxxxxx',
                                            style: TextStyle(
                                              fontFamily:
                                                  'Jameel Noori Nastaleeq Kasheeda',
                                              color: Colors.white,
                                              fontSize: 16,
                                            )),
                                      ]),
                                ),
                              );
                            else
                              return CircularProgressIndicator();
                          }),
                      FutureBuilder(
                          future: getUserCredentials(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData)
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                       DemoLocalization.of(context)
                        .getTranslatedValue('CNIC'),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              'Jameel Noori Nastaleeq Kasheeda',
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                          cnic != null
                                              ? cnic
                                              : 'xxxxx-xxxxxx-x',
                                          style: TextStyle(
                                            fontFamily:
                                                'Jameel Noori Nastaleeq Kasheeda',
                                            color: Colors.white,
                                            fontSize: 16,
                                          )),
                                    ]),
                              );
                            else
                              return CircularProgressIndicator();
                          }),
                    ],
                  ),
                ),
              ),
    
        
        
        Divider(),
        ListTile(
          title: Text(DemoLocalization.of(context)
                        .getTranslatedValue('Settings'),
                         style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                      ),),
          leading: Icon(Icons.settings),
          onLongPress: () {},
        ),
        Divider(),
        ListTile(
            title: Text(DemoLocalization.of(context)
                        .getTranslatedValue('LogOut'), style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                      ),),
            leading: Icon(Icons.close),
            onTap: () async {
              if (googleauth.abc.isGoogleLoggedIn) {
                googleauth.abc.logout(context);
              } else {
                final auth = FirebaseAuth.instance;
                auth.signOut();
              }

              SharedPreferences sp = await SharedPreferences.getInstance();
              sp.setBool("SignedInPatient", false);
              while (Navigator.canPop(context)) {
                Navigator.pop(context);
              }

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => PatientLogin()),
              );

              context.read<LoginPatientData>().loading = false;
            }),
      ]),
    );
  }
}
