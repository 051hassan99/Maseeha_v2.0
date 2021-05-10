import 'package:flutter/material.dart';
import 'package:maseeha_update/Patient/patientScreens/main_drawer.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../lang_selector.dart';
import 'CallPage.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  bool _validateError = false;
  final PermissionHandler _permissionHandler = PermissionHandler();
  
  Future<void> onJoin() async{
    setState(() {
      myController.text.isEmpty 
      ? _validateError = true
      : _validateError = false;
    });
    await _permissionHandler.requestPermissions([PermissionGroup.camera, PermissionGroup.microphone]);

    Navigator.push(context, 
    MaterialPageRoute(
      builder: (context)=> CallPage(channelName: myController.text),)
    );
  }

  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
     appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(
              right: size.width / 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: size.width * 0.28,
                  child: Center(
                    child: Text(
                      DemoLocalization.of(context).getTranslatedValue('title'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(
                  left: size.width / 30,
                  right: size.width / 30,
                ),
                child: LangSelector()),
          ],
        ),
        drawer: MainDrawer(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top:100)),
            Padding(padding: EdgeInsets.only(top:20)),
            Text('Please Enter the channel name in below TextField ',
             style: TextStyle(color: Colors.black, fontSize: 20,
             fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
              fontWeight: FontWeight.bold),           
             ),
            Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            Container(
              width: 300,
              child: TextFormField(
                controller: myController,
                decoration: InputDecoration(
                  labelText: 'Channel Name',
                  labelStyle: TextStyle(color: Colors.blue,
                  fontFamily: 'Jameel Noori Nastaleeq Kasheeda'),
                  hintText: 'test',
                  hintStyle: TextStyle(color: Colors.black45,
                  fontFamily: 'Jameel Noori Nastaleeq Kasheeda',),
                  errorText: _validateError ? 'Channel name is mandatory' : null,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 30)),
              Container(
              width: 90,
              child: MaterialButton(
                onPressed: onJoin,
                height: 40,
                color: Colors.blueAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Join', style: TextStyle(color: Colors.white,
                    fontFamily: 'Jameel Noori Nastaleeq Kasheeda',)),
                    Icon(Icons.arrow_forward,color: Colors.white),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}