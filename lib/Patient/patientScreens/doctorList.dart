import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maseeha_update/Assistants/firestore_assitant.dart';
import 'package:maseeha_update/Notification/notification.dart';
import 'package:maseeha_update/Patient/patientScreensData/loginPatientData.dart';
import 'package:maseeha_update/Patient/patientScreensData/newAppointmentdata.dart';
import 'package:maseeha_update/classes/doctor.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:maseeha_update/token.dart';
import 'package:provider/provider.dart';
import '../../lang_selector.dart';
import 'newAppointment.dart';
//import 'package:path/path.dart';

class DoctorList extends StatelessWidget {
  static const String id = 'doctors_list';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final patientEmail =
        context.read<LoginPatientData>().getCurrentPatientData();

    final firestoreAssitant = FirestoreAssitant();
    final newApponitmentData =
        Provider.of<NewAppointmentData>(context, listen: false);

    final notification = Provider.of<NotificationSend>(context, listen: false);
    final token = Provider.of<Token>(context, listen: false);

    void takeAnAppointment(BuildContext context) => showDialog(
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
              content: NewAppointment(),
              actions: [
                // ignore: deprecated_member_use
                FlatButton(
                    child: Text(
                      DemoLocalization.of(context).getTranslatedValue('submit'),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                          color: Colors.blue),
                    ),
                    onPressed: () async {
                      try {
                        print('Uploading data');
                        context.read<Token>().targetUserEmail =
                            context.read<NewAppointmentData>().docEmail;
                        context.read<NotificationSend>().senderName =
                            context.read<NewAppointmentData>().name;
                        context.read<NotificationSend>().notificationType =
                            "Appointment";
                        final appointmentSent = await firestoreAssitant
                            .sendAppointment(newApponitmentData);

                        if (appointmentSent) {
                          Fluttertoast.showToast(
                              msg: 'You have Succefully Created an appointment',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.blue,
                              textColor: Colors.yellow);
                          final tokenID = await token.getTokenId();
                          await notification.sendNotifications(tokenID);
                          Navigator.pop(context);
                        }
                        //notification.checkUpdate();
                        //token.checkUser();
                        else {
                          Fluttertoast.showToast(
                              msg: 'Please Try again',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.blue,
                              textColor: Colors.yellow);
                        }
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
        });

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
                      fontFamily:
                                                    'Jameel Noori Nastaleeq Kasheeda'
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
              stream: _firestore.collection('doctors').snapshots(),
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final doctors = snapshot.data.docs;
                print(doctors.length);

                List<Widget> doctorCards = [];
                for (var doctor in doctors) {
                  Doctor doc = Doctor.fromJson(doctor.data());

                  doctorCards.add(Container(
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
                                      doc.fullName ?? 'No data',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    doc.hospital ?? 'No data',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
                                    ),
                                  ),
                                  Text(
                                    doc.docEmail ?? 'No data',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
                                    ),
                                  ),
                                  Text(
                                    doc.specialization ?? 'No data',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
                                    ),
                                  ),
                                  // ignore: deprecated_member_use
                                  FlatButton(
                                    child: Text(
                                       DemoLocalization.of(context).getTranslatedValue('clickHere'),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    onPressed: () {
                                      try {
                                        context
                                            .read<NewAppointmentData>()
                                            .doctorName = doc.fullName;
                                        context
                                            .read<NewAppointmentData>()
                                            .docEmail = doc.docEmail;
                                        context
                                            .read<NewAppointmentData>()
                                            .patientEmail = patientEmail;
                                        takeAnAppointment(context);
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
                  children: doctorCards,
                );
              },
            )),
      ),
    );
  }
}
