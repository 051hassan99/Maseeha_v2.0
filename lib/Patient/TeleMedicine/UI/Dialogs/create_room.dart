import 'package:maseeha_update/Patient/TeleMedicine/Helpers/utils.dart';
import 'package:maseeha_update/Patient/TeleMedicine/UI/videocall_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maseeha_update/localization/demo_localization.dart';

class CreateRoomDialog extends StatefulWidget {
  @override
  _CreateRoomDialogState createState() => _CreateRoomDialogState();
}

class _CreateRoomDialogState extends State<CreateRoomDialog> {
  String roomId = "";



   createShareRoomIDDialog(BuildContext context){

      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(

            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

            title: Text( DemoLocalization.of(context)
                  .getTranslatedValue('sendIt'),
                   style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
              ),),

            content: Column(

              mainAxisSize: MainAxisSize.min,
              children:[
              

                // ignore: deprecated_member_use
                FlatButton(
                  child: Text( DemoLocalization.of(context)
                  .getTranslatedValue('thisApp'),
                   style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
              ),),
                  onPressed: (){


                  },
                ),
               
                // ignore: deprecated_member_use
                FlatButton(
                  child: Text( DemoLocalization.of(context)
                  .getTranslatedValue('otherApps'),
                   style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
              ),),
                  onPressed: (){

                     shareToApps(roomId);
                    
                  },
                ),
              ]
            ),
          );

        }
      );
  }


  sendRoomIDThroughPassowordDialog(BuildContext context) {
    
    String email;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              DemoLocalization.of(context)
                  .getTranslatedValue('messagefrommaseeha'),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
              ),
            ),
            content: TextFormField(
              decoration: InputDecoration(
                hintText:
                    DemoLocalization.of(context).getTranslatedValue('eemail'),
                hintStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                ),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return DemoLocalization.of(context)
                      .getTranslatedValue('emailrequired');
                }
                return null;
              },
              onChanged: (value) {
                email = value;
              },
            ),
            actions: [
              // ignore: deprecated_member_use
              FlatButton(
                child: Text(
                  DemoLocalization.of(context).getTranslatedValue('submit'),
                ),
                onPressed: () async {
                 
                    print(email);
               /*   Navigator.pop(context);

                  Fluttertoast.showToast(
                      msg: 'New Password Link has been sent to your email',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.blue,
                      textColor: Colors.yellow);    */
                },
              )
            ],
          );
        });
  }
  @override
  void initState() {
    roomId = generateRandomString(8);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(  DemoLocalization.of(context).getTranslatedValue(
                        'roomCreated',
                      ),
                      style: TextStyle(
                         fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                          color: Theme.of(context).primaryColor
                      ),),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/room_created_vector.png',
          ),
          Text(
              DemoLocalization.of(context).getTranslatedValue(
                        'roomId',
                      ) +"    "+  roomId,
            style:  TextStyle(color: const Color(0xFF1A1E78),
             fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FittedBox(
            fit: BoxFit.contain,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ignore: deprecated_member_use
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    createShareRoomIDDialog(context);
                  },
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                   Icon(Icons.share, color: Colors.white,),
                   const SizedBox(
                     width: 10,
                   ),
                   Text(
                       DemoLocalization.of(context).getTranslatedValue(
                       'share',
                     ),
                     style: TextStyle(
                        fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                         color: Colors.white
                     ),
                     
                   ),
                      ],
                    ),
                ),

                 const SizedBox(
            width: 20,
          ),
                // ignore: deprecated_member_use
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    bool isPermissionGranted =
                        await handlePermissionsForCall(context);
                    if (isPermissionGranted) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VideoCallScreen(
                                    channelName: roomId,
                                  )));
                    } else {
                      Get.snackbar("Failed",
                          "Microphone Permission Required for Video Call.",
                          backgroundColor: Colors.white,
                          colorText: Color(0xFF1A1E78),
                          snackPosition: SnackPosition.BOTTOM);
                    }
                  },
                  child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_forward, color: Colors.white),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                       DemoLocalization.of(context).getTranslatedValue(
                        'join',
                      ),
                      style: TextStyle(
                         fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                         color: Colors.white
                      ),
                    ),
                  ],
                    ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
