import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maseeha_update/Doctor/doctorScreens/doctor_login.dart';
import 'package:maseeha_update/classes/doctor.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorDrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final doctorData = Provider.of<Doctor>(context, listen: false);

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Container(
          height: 400,
          width: double.infinity,
          padding: EdgeInsets.all(30),
          color: Theme.of(context).primaryColor,
          child: Column(
            children: <Widget>[
              Container(
                width: 80,
                height: 120,
                margin: EdgeInsets.only(
                  top: 30,
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
                          doctorData.userList[D.doctorName.index] != null
                              ? doctorData.userList[D.doctorName.index]
                              : 'No Name',
                          style: TextStyle(
                            fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
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
                          doctorData.userList[D.email.index] != null
                              ? doctorData.userList[D.email.index]
                              : 'Not Found',
                          style: TextStyle(
                            fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
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
                        "PMDC No ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                          doctorData.userList[D.pmdc.index] != null
                              ? doctorData.userList[D.pmdc.index]
                              : 'Mark ZukerBerg',
                          style: TextStyle(
                            fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
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
                        .getTranslatedValue('specialization'),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                          doctorData.userList[D.specialization.index] != null
                              ? doctorData.userList[D.specialization.index]
                              : 'Mark ZukerBerg',
                          style: TextStyle(
                            fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                            color: Colors.white,
                            fontSize: 16,
                          )),
                    ]),
              ),
            ],
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
              final auth = FirebaseAuth.instance;
              auth.signOut();
              SharedPreferences sp = await SharedPreferences.getInstance();
              sp.setBool("SignedInDoctor", false);

              while (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DoctorLogin()),
              );
            }),
      ]),
    );
  }
}
