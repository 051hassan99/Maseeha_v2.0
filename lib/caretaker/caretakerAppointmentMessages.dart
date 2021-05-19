import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maseeha_update/Assistants/firestore_assitant.dart';
import 'package:maseeha_update/Caretaker/caretakerAppointmentReplyData.dart';
import 'package:maseeha_update/Caretaker/loginCaretakerData.dart';
import 'package:maseeha_update/Patient/caretakerAppointment/caretakerNewAppointmentData.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';

import '../lang_selector.dart';


class CaretakerAppointmentMessages extends StatelessWidget {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //hassan
  final firestoreAssitant = FirestoreAssitant();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final appointmentReplyData =
        Provider.of<CaretakerAppointmentReplyData>(context, listen: false);

    void appointmentMessageReply(context, doctorName, doctorEmail, patientName,
            patientEmail) =>
        showDialog(
            context: context,
            // ignore: missing_return
            builder: (context) {
            
                return AlertDialog(
                  title: Container(
                    height: 50,
                    width: 100,
                    child: Center(
                      child: Text(
                        'Are you want to accept appointment request?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                           fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    // ignore: deprecated_member_use
                    FlatButton(
                        child: Text('Yes'),
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
                                                      'Please Enter your message',
                                                  hintStyle: TextStyle(
                                                         fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
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
                                        child: Text('Submit'),
                                        onPressed: () {
                                          context
                                              .read<CaretakerAppointmentReplyData>()
                                              .caretakerEmail = doctorEmail;
                                          context
                                              .read<CaretakerAppointmentReplyData>()
                                              .caretakerName = doctorName;
                                          context
                                              .read<CaretakerAppointmentReplyData>()
                                              .patientName = patientName;
                                          context
                                              .read<CaretakerAppointmentReplyData>()
                                              .patientEmail = patientEmail;
                                            print("Uploading Data ........");

                                            firestoreAssitant.sendCaretaklerApointmentReply(appointmentReplyData);
                                          
                                          Navigator.pop(context);
                                        }),
                                    // ignore: deprecated_member_use
                                    FlatButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ],
                                );
                              });
                        }),
                    // ignore: deprecated_member_use
                    FlatButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                );
              }
            );
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
                       fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
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
                  .collection('caretakerAppointments')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                List<Widget> appointmentCard = [];
                CaretakerNewAppointmentData message;

                final appointMessages = snapshot.data.docs;
                final currentCaretakerEmail =
                    context.read<LoginCaretakerData>().getCurrentCaretakerrData();

                for (var appointment in appointMessages) {
                  if (currentCaretakerEmail == appointment['CaretakerEmail']) {
                    message =  CaretakerNewAppointmentData .fromJson(appointment.data());
                  }
                  final patientName = message.name;
                  final patientEmail = message.patientEmail;
                  final caretakerName = message.caretakerName;
                  final caretakerEmail = message.caretakerEmail;
                 

                  appointmentCard.add(
                    GestureDetector(
                      child: MessageAppointment(size: size, message: message),
                      onTap: () {
                        

                        appointmentMessageReply(
                            context,
                            caretakerName,
                           caretakerEmail,
                            patientName,
                            patientEmail,
                            );
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
  final CaretakerNewAppointmentData message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        height: size.height * 0.22,
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                Container(
                  child: Text(
                    '  Patient Name:   ',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                         fontFamily: 'Jameel Noori Nastaleeq Kasheeda'),
                  ),
                ),
                Container(
                  child: Text(
                    message.name?? 'No data',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),


            SizedBox(height: 10),
            Row(
              children: [
                Container(
                  child: Text(
                    '  Patient Age:      ',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                         fontFamily: 'Jameel Noori Nastaleeq Kasheeda'),
                  ),
                ),
                Container(
                  child: Text(
                    message.age.toString() ?? 'No data',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Container(
                  child: Text(
                    '  Phone Number:   ',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                         fontFamily: 'Jameel Noori Nastaleeq Kasheeda'),
                  ),
                ),
                Container(
                  child: Text(
                    message.phonenumber ?? 'No data',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Container(
                  child: Text(
                    '  Patient Disease:   ',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                         fontFamily: 'Jameel Noori Nastaleeq Kasheeda'),
                  ),
                ),
                Container(
                  child: Text(
                    message.diseaseDescription ?? 'No data',
                    style: TextStyle(
                      fontSize: 12,
                    ),
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
