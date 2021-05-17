import 'package:maseeha_update/Patient/TeleMedicine/UI/Dialogs/create_room.dart';
import 'package:maseeha_update/Patient/TeleMedicine/UI/Dialogs/join_room.dart';
import 'package:flutter/material.dart';
import 'package:maseeha_update/lang_selector.dart';
import 'package:maseeha_update/localization/demo_localization.dart';

class TeleMedicineHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [LangSelector(), SizedBox(width: 15)],
            ),
            Container(
              margin: const EdgeInsets.only(left: 30),
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      DemoLocalization.of(context).getTranslatedValue(
                        'maseehaVideoZone',
                      ),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                          color: Colors.white,
                          fontSize: 28),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      DemoLocalization.of(context).getTranslatedValue(
                        'videoDescription',
                      ),
                      style: TextStyle(
                          fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(
                  top: 30,
                ),
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Center(
                    child: Column(
                  children: [
                    Flexible(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) {
                                  return CreateRoomDialog();
                                });
                          },
                          child: Row(
                            children: [
                              Flexible(
                                  flex: 7,
                                  child: Image.asset(
                                    "assets/images/create_meeting_vector.png",
                                    fit: BoxFit.fill,
                                  )),
                              Flexible(
                                flex: 4,
                                child: Column(
                                  children: [
                                    Text(
                                      DemoLocalization.of(context)
                                          .getTranslatedValue(
                                        'createRoom',
                                      ),
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontFamily:
                                              'Jameel Noori Nastaleeq Kasheeda',
                                          fontSize: 20),
                                    ),
                                     SizedBox(height: 10),
                                    Text(
                                      DemoLocalization.of(context)
                                          .getTranslatedValue(
                                        'createRoomDescription',
                                      ),
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontFamily:
                                              'Jameel Noori Nastaleeq Kasheeda',
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 2,
                          margin: const EdgeInsets.all(20),
                          color: Theme.of(context).primaryColor),
                    ),
                    Flexible(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) {
                                  return JoinRoomDialog();
                                });
                          },
                          child: Row(
                            children: [
                              Flexible(
                                  flex: 6,
                                  child: Image.asset(
                                    "assets/images/join_meeting_vector.png",
                                    fit: BoxFit.fill,
                                  )),
                              Flexible(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    
                                    FittedBox(
                                      fit: BoxFit.contain,
                                            child: Row(

                                        children:[ 
                                          SizedBox(width: 14),
                                          Text(
                                          DemoLocalization.of(context)
                                              .getTranslatedValue(
                                            'joinRoom',
                                          ),
                                          style: TextStyle(
                                              color: Theme.of(context).primaryColor,
                                              fontFamily:
                                                  'Jameel Noori Nastaleeq Kasheeda',
                                              fontSize: 20),
                                        ),
                                        ]
                                      ),
                                    ),

                                    SizedBox(height: 10),
                                    Text(
                                      DemoLocalization.of(context)
                                          .getTranslatedValue(
                                        'joinRoomDescription',
                                      ),
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontFamily:
                                              'Jameel Noori Nastaleeq Kasheeda',
                                               fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
