import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maseeha_update/Assistants/firestore_assitant.dart';
import 'package:maseeha_update/Doctor/appointmentReply/appointmentReply.dart';
import 'package:maseeha_update/Doctor/doctorScreensData/doctorRegisterData.dart';
import 'package:maseeha_update/Notification/notification.dart';
import 'package:maseeha_update/Patient/patientScreensData/newAppointmentdata.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';

import '../../lang_selector.dart';
import '../../token.dart';

class Appointments extends StatelessWidget {
  static const String id = 'appointments_screen';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //hassan
  final firestoreAssitant = FirestoreAssitant();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final appointmentReplyData =
        Provider.of<AppointmentReply>(context, listen: false);
      final notification = Provider.of<NotificationSend>(context, listen: false);
    final token = Provider.of<Token>(context, listen: false);

    void appointmentMessageReply(context, doctorName, doctorEmail, patientName,
            patientEmail, appointmentType) =>
        showDialog(
            context: context,
            // ignore: missing_return
            builder: (context) {
              if (appointmentType == 'Online') {
                return AlertDialog(
                  title: Container(
                    height: 50,
                    width: 100,
                    child: Center(
                      child: Text(
                        'Are you want to accept appointment request?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).primaryColor,
                             fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    // ignore: deprecated_member_use
                    FlatButton(
                        child: Text( DemoLocalization.of(context)
                                            .getTranslatedValue('yes'),style: TextStyle(
                             fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                              fontWeight: FontWeight.bold,
                        ),),
                        onPressed: () {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Container(
                                    child: Center(
                                      child: Text(
                                        DemoLocalization.of(context)
                                            .getTranslatedValue('fillform'),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Theme.of(context).primaryColor,
                                             fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
                                        ),
                                      ),
                                    ),
                                  ),
                                  content: SingleChildScrollView(
                                    child: Container(
                                      width: double.infinity,
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextFormField(
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                hintText:
                                                    'Enter Timing in format April 23, 2021/11:00 AM',
                                                hintStyle: TextStyle(
                                                  fontSize: 12,
                                                     fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                                                      fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  return DemoLocalization.of(
                                                          context)
                                                      .getTranslatedValue(
                                                          'namerequired');
                                                }
                                                return null;
                                              },
                                              onChanged: (String value) {
                                                appointmentReplyData
                                                        .appointmentReplyMessage =
                                                    value;
                                              },
                                            )
                                          ]),
                                    ),
                                  ),
                                  actions: [
                                    // ignore: deprecated_member_use
                                    FlatButton(
                                        child: Text( DemoLocalization.of(context)
                                            .getTranslatedValue('submit'),style: TextStyle(
                                              fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                                               fontWeight: FontWeight.bold,
                                            ),),
                                        onPressed: () async{
                                          context
                                              .read<AppointmentReply>()
                                              .docEmail = doctorEmail;
                                          context
                                              .read<AppointmentReply>()
                                              .docName = doctorName;
                                          context
                                              .read<AppointmentReply>()
                                              .patientName = patientName;
                                          context
                                              .read<AppointmentReply>()
                                              .patientEmail = patientEmail;
                                          context.read<NotificationSend>().notificationType =
                                        "Appointment Reply";
                                           context.read<NotificationSend>().senderName = patientName;
                                             context.read<Token>().targetUserEmail = patientEmail;
                                             
                                          firestoreAssitant.sendApointmentReply(
                                              appointmentReplyData);

                                           Fluttertoast.showToast(
                              msg: 'You have Succefully replied an appointment',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.blue,
                              textColor: Colors.yellow);
                          final tokenID = await token.getTokenId();

                           print("TOKEN ID \n");
                          print(tokenID);
                          await notification.sendNotifications(tokenID);
                    
                                          Navigator.pop(context);
                                        }),
                                    // ignore: deprecated_member_use
                                    FlatButton(
                                        child: Text( DemoLocalization.of(context)
                                            .getTranslatedValue('Cancel'),style: TextStyle(
                                              fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                                               fontWeight: FontWeight.bold,
                                            ),),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        })
                                  ],
                                );
                              });
                        }),
                    // ignore: deprecated_member_use
                    FlatButton(
                        child: Text( DemoLocalization.of(context)
                                            .getTranslatedValue('no'),
                        style: TextStyle(
                         
                                              fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                                               fontWeight: FontWeight.bold,
                                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                );
              }

              if (appointmentType == 'Physical') {
                return AlertDialog(
                  title: Container(
                    height: 50,
                    width: 100,
                    child: Center(
                      child: Text(
                        'Are you want to accept appointment request?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).primaryColor,
                          fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
                        ),

                      ),
                    ),
                  ),
                  actions: [
                    // ignore: deprecated_member_use
                    FlatButton(
                        child: Text( DemoLocalization.of(context)
                                            .getTranslatedValue('yes'),style: TextStyle(
                          fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                           fontWeight: FontWeight.bold,
                        ),),
                        onPressed: () {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Container(
                                    child: Center(
                                      child: Text(
                                        DemoLocalization.of(context)
                                            .getTranslatedValue('fillform'),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Theme.of(context).primaryColor,
                                          fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
                                        ),
                                      ),
                                    ),
                                  ),
                                  content: SingleChildScrollView(
                                    child: Container(
                                      width: double.infinity,
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextFormField(
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                  hintText:
                                                      'Please Enter the address',
                                                      hintStyle: TextStyle(
                                                        fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                                                         fontWeight: FontWeight.bold,
                                                      )),
                                                      
                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  return DemoLocalization.of(
                                                          context)
                                                      .getTranslatedValue(
                                                          'namerequired');
                                                }
                                                return null;
                                              },
                                              onChanged: (String value) {
                                                appointmentReplyData
                                                        .appointmentReplyMessage =
                                                    value;
                                              },
                                            )
                                          ]),
                                    ),
                                  ),
                                  actions: [
                                    // ignore: deprecated_member_use
                                    FlatButton(
                                        child: Text( DemoLocalization.of(context)
                                            .getTranslatedValue('submit'),style: TextStyle(
                                              fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                                               fontWeight: FontWeight.bold,
                                            ),),
                                        onPressed: ()async {
                                          context
                                              .read<AppointmentReply>()
                                              .docEmail = doctorEmail;
                                          context
                                              .read<AppointmentReply>()
                                              .docName = doctorName;
                                          context
                                              .read<AppointmentReply>()
                                              .patientName = patientName;
                                          context
                                              .read<AppointmentReply>()
                                              .patientEmail = patientEmail;
                                          context.read<NotificationSend>().notificationType =
                                        "Appointment Reply";
                                           context.read<NotificationSend>().senderName = patientName;
                                             context.read<Token>().targetUserEmail = patientEmail;
                                             
                                          firestoreAssitant.sendApointmentReply(
                                              appointmentReplyData);

                                           Fluttertoast.showToast(
                              msg: 'You have Succefully Rreplied an appointment',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.blue,
                              textColor: Colors.yellow);
                          final tokenID = await token.getTokenId();

                          print("TOKEN ID \n");
                          print(tokenID);
                          await notification.sendNotifications(tokenID);
                    
                                          Navigator.pop(context);
                                        }),
                                  ],
                                );
                              });
                        }),
                    // ignore: deprecated_member_use
                    FlatButton(
                        child: Text( DemoLocalization.of(context)
                                            .getTranslatedValue('no'),style: TextStyle(
                          fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                                               fontWeight: FontWeight.bold,

                        ),),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                );
              }
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
      body: Center(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width / 8),
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('appointments')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                List<Widget> appointmentCard = [];
                NewAppointmentData message;

                final appointMessages = snapshot.data.docs;
                final currentDocEmail =
                    context.read<DoctorRegisterData>().getCurrentDoctorData();

                for (var appointment in appointMessages) {
                  if (currentDocEmail == appointment['docEmail']) {
                    message = NewAppointmentData.fromJson(appointment.data());
                  }
                  final patientName = message.name;
                  final patientEmail = message.patientEmail;
                  final doctorName = message.doctorName;
                  final doctorEmail = message.docEmail;
                  final appointmentType = message.appointmenttype;

                  appointmentCard.add(
                    GestureDetector(
                      child: MessageAppointment(size: size, message: message),
                      onTap: () {
                        print("Appointment Type is " + appointmentType);

                        appointmentMessageReply(
                            context,
                            doctorName,
                            doctorEmail,
                            patientName,
                            patientEmail,
                            appointmentType);
                      },
                    ),
                  );
                }
                return ListView(
                  children: appointmentCard,
                );
              },
            )),
      ),
    );
  }
}

class MessageAppointment extends StatelessWidget {
  const MessageAppointment({
    Key key,
    @required this.size,
    @required this.message,
  }) : super(key: key);

  final Size size;
  final NewAppointmentData message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        height: size.height * 0.3,
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                 SizedBox(width: 10),
                Text(
                 DemoLocalization.of(context)
                                          .getTranslatedValue('PatientName'),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                       fontFamily: 'Jameel Noori Nastaleeq Kasheeda'),
                ),
                 SizedBox(width: 30),
                Text(
                  message.name ?? 'No data',
                  style: TextStyle(
                    fontSize: 14,
                     fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            Row(
              children: [
                  SizedBox(width: 10),
                Text(
                  DemoLocalization.of(context)
                                          .getTranslatedValue('PatientEmail'),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                       fontFamily: 'Jameel Noori Nastaleeq Kasheeda'),
                ),
                 SizedBox(width: 20),
                FittedBox(
                  fit: BoxFit.contain,
                      child: Text(
                    message.patientEmail ?? 'No data',
                    style: TextStyle(
                      fontSize: 14,
                       fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                  SizedBox(width: 10),
                Text(
                   DemoLocalization.of(context)
                                          .getTranslatedValue('PatientAge'),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                       fontFamily: 'Jameel Noori Nastaleeq Kasheeda'),
                ),
                 SizedBox(width: 40),
                Text(
                  message.age.toString() ?? 'No data',
                  style: TextStyle(
                    fontSize: 14,
                     fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                 SizedBox(width: 10),
                Text(
                  DemoLocalization.of(context)
                                          .getTranslatedValue('AppointmentType'),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                       fontFamily: 'Jameel Noori Nastaleeq Kasheeda'),
                ),
                  SizedBox(width: 30),
                Text(
                  message.appointmenttype ?? 'No data',
                  style: TextStyle(
                    fontSize: 14,
                     fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                 SizedBox(width: 10),
                Text(
                   DemoLocalization.of(context)
                                          .getTranslatedValue('PatientDisease'),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                       fontFamily: 'Jameel Noori Nastaleeq Kasheeda'),
                ),
                 SizedBox(width: 30),
                Text(
                  message.diseaseDescription ?? 'No data',
                  style: TextStyle(
                    fontSize: 14,
                     fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
                  ),
                ),
              ],
            ),

            // ignore: deprecated_member_use
          ],
        ),
      ),
    );
  }
}
