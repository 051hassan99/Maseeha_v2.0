import 'package:flutter/material.dart';
import 'package:maseeha_update/localization/demo_localization.dart';

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
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/images/doctor.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Text(
                    'username',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'username@gmail.com',
                    style: TextStyle(
                      color: Colors.white,
                    ),
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
            onTap: null,
          ),
        ],
      ),
    );
  }
}
