import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maseeha_update/Caretaker/caretaker_login.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:maseeha_update/Assistants/authAssistant.dart' as auth_assistant;

class CaretakerDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                children: <Widget>[
                 
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 30,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(auth_assistant.abc.userProfileList[auth_assistant.E.photoURL.index] !=
                                null
                            ? auth_assistant.abc.userProfileList[auth_assistant.E.photoURL.index]
                            : 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fflutterappworld.com%2Fa-high-performance-flutter-widget-to-render-bottts-svg-avatars%2F&psig=AOvVaw0pbd2aLdtAYDPZSY8ZCbFK&ust=1605966714142000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCODx_sSike0CFQAAAAAdAAAAABAJ'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      auth_assistant.abc.userProfileList[auth_assistant.E.email.index]!=
                              null
                          ? auth_assistant.abc.userProfileList[auth_assistant.E.email.index]
                          : 'abc@gmail.com',
                    ),
                  ),
                  Text(
                  auth_assistant.abc.userProfileList[auth_assistant.E.username.index] !=
                            null
                        ?auth_assistant.abc.userProfileList[auth_assistant.E.username.index]
                        : 'abc@gmail.com',
                  ),
                ],
              ),
            ),
          ),
          
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              DemoLocalization.of(context).getTranslatedValue('Profile'),
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              DemoLocalization.of(context).getTranslatedValue('Settings'),
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: null,
          ),
          ListTile(
              leading: Icon(Icons.arrow_back),
              title: Text(
                DemoLocalization.of(context).getTranslatedValue('LogOut'),
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onTap: () async{
               
                  final auth = FirebaseAuth.instance;
                  auth.signOut();
                 // SharedPreferences sp = await SharedPreferences.getInstance();
                 // sp.setBool("SignedInPatient", false);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CaretakerLogin()),
                  );
              
              }),
        ],
      ),
    );
  }
}
