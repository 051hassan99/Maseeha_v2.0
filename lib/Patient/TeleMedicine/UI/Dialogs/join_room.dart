import 'package:maseeha_update/Patient/TeleMedicine/Helpers/utils.dart';
import 'package:maseeha_update/Patient/TeleMedicine/UI/videocall_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maseeha_update/localization/demo_localization.dart';


class JoinRoomDialog extends StatelessWidget {
  final TextEditingController roomTxtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(  DemoLocalization.of(context)
                                              .getTranslatedValue(
                                            'joinRoom',
                                          ),
                                          style: TextStyle(
                                              color: Theme.of(context).primaryColor,
                                              fontFamily:
                                                  'Jameel Noori Nastaleeq Kasheeda',
                                              fontSize: 20),),
      content: ListView(
        shrinkWrap: true,
        children: [
          Image.asset(
            'assets/images/room_join_vector.png',
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: roomTxtController,
            decoration: InputDecoration(
                hintText: "Enter room id to join",
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: const Color(0xFF1A1E78), width: 2)),
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor, width: 2))),
            style: TextStyle(
                color: const Color(0xFF1A1E78), fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 20,
          ),
       
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40.0),
            // ignore: deprecated_member_use
            child: FlatButton(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                if (roomTxtController.text.isNotEmpty) {
                  bool isPermissionGranted =
                      await handlePermissionsForCall(context);
                  if (isPermissionGranted) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoCallScreen(
                                  channelName: roomTxtController.text,
                                )));
                  } else {
                    Get.snackbar("Failed", "Enter Room-Id to Join.",
                        backgroundColor: Colors.white,
                        colorText: Color(0xFF1A1E78),
                        snackPosition: SnackPosition.BOTTOM);
                  }
                } else {
                  Get.snackbar(
                      "Failed", "Microphone Permission Required for Video Call.",
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
                    width: 20,
                  ),
                  Text(
                    "Join Room",
                    style: TextStyle(
                      color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
