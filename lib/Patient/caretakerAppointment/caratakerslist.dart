import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maseeha_update/Assistants/firestore_assitant.dart';
import 'package:maseeha_update/Notification/notification.dart';
import 'package:maseeha_update/Patient/caretakerAppointment/caretakerNewAppointment.dart';
import 'package:maseeha_update/Patient/caretakerAppointment/caretakerNewAppointmentData.dart';
import 'package:maseeha_update/Patient/patientScreensData/loginPatientData.dart';
import 'package:maseeha_update/classes/caretaker.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';

import '../../lang_selector.dart';
import '../../token.dart';


class CaretakerList extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
     final firestoreAssitant = FirestoreAssitant();

  @override
  Widget build(BuildContext context) {

     final patientEmail =
        context.read<LoginPatientData>().getCurrentPatientData();

    final caretakerAppointmentData =
        Provider.of<CaretakerNewAppointmentData>(context, listen: false);
   void takeCaretakerAppointment(BuildContext context) => showDialog(
        context: context,
        builder: (_) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: Container(
                child: Center(
                  child: Text(
                    DemoLocalization.of(context).getTranslatedValue('fillform'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily:
                                                    'Jameel Noori Nastaleeq Kasheeda',
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              content: CaretakerNewAppointment(),

              actions: [

                // ignore: deprecated_member_use
                FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Text(
                  DemoLocalization.of(context).getTranslatedValue('submit'),
                  style: TextStyle(
                       fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                      color: Theme.of(context).primaryColor),
                ),
                onPressed: () async {
                  try {
                    print('Uploading data');

                    context.read<Token>().targetUserEmail =
                            context.read<CaretakerNewAppointmentData>().caretakerEmail;
                        context.read<NotificationSend>().senderName =
                            context.read<CaretakerNewAppointmentData>().name;
                        context.read<NotificationSend>().notificationType =
                            "Appointment";
                            
                    firestoreAssitant
                        .sendCaretakerAppointment(caretakerAppointmentData);
                       Fluttertoast.showToast(
                              msg: 'You have Succefully Created an appointment',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.blue,
                              textColor: Colors.yellow);
                              Navigator.pop(context);
                  } catch (_) {
                    print('Failed to upload');
                  }
                }),

                  // ignore: deprecated_member_use
                  FlatButton(
                    child: Text(
                      DemoLocalization.of(context).getTranslatedValue('Cancel'),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                          color: Colors.blue),
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    }),
          
              ],
      
            
            ),
          );
        },
   );

    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
      body: Container(
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width / 8,
            ),
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('caretakers').snapshots(),
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final caretakers = snapshot.data.docs;
      

                List<Widget> caretakerCards = [];
                for (var caretaker in caretakers) {
                  Caretaker ckts = Caretaker.fromJson(caretaker.data());
                  caretakerCards.add(Container(
                    padding: EdgeInsets.only(
                      top: 10,
                    ),
                    child: Card(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Row(
                          children: [
                            Container(
                              height: size.height / 10,
                              width: 120,
                              margin: EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                 image: DecorationImage(
                                      image: NetworkImage(
                                          'https://images.unsplash.com/photo-1486312338219-ce68d2c6f44d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=752&q=80'),
                                    ), 
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                              padding: EdgeInsets.all(5),
                            ),
                            Container(
                              height: 180,
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(size.width / 30),
                                    child: Text(
                                      ckts.name ?? 'No data',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                           fontFamily: 'Jameel Noori Nastaleeq Kasheeda',),
                                    ),
                                  ),
                                  Text(
                                    ckts.pnc ?? 'No data',
                                    style: TextStyle(
                                      fontSize: 12,
                                       fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                                    ),
                                  ),
                                  Text(
                                    ckts.caretakerEmail ?? 'No data',
                                    style: TextStyle(
                                      fontSize: 12,
                                       fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                                    ),
                                  ),
                                  // ignore: deprecated_member_use
                                  FlatButton(
                                    child: Text(
                                      'Click Here ',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    onPressed: () {
                                      try {
                                        context
                                            .read<CaretakerNewAppointmentData>().caretakerName
                                             = ckts.name;
                                        context
                                            .read<CaretakerNewAppointmentData>()
                                            .caretakerEmail = ckts.caretakerEmail;
                                        context
                                            .read<CaretakerNewAppointmentData>()
                                            .patientEmail = patientEmail;
                                        takeCaretakerAppointment(context);
                                      } catch (err) {
                                        print(err.toString());
                                      }
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
                }
                return ListView(
                  children: caretakerCards,
                );
              },
            )),
      ),
    );
  }
   
  }

