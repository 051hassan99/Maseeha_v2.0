import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maseeha_update/Assistants/firestore_assitant.dart';
import 'package:maseeha_update/Doctor/appointmentReply/appointmentReply.dart';
import 'package:maseeha_update/Doctor/doctorScreensData/doctorRegisterData.dart';
import 'package:maseeha_update/Patient/patientScreensData/newAppointmentdata.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';

import '../../lang_selector.dart';

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
                        style: GoogleFonts.rajdhani(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
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
                                        style: GoogleFonts.rajdhani(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
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
                                                    'Enter Timing in format April 23, 2021/11:00 AM',
                                                hintStyle: TextStyle(
                                                  fontSize: 12,
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
                                        child: Text('Submit'),
                                        onPressed: () {
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
                                          firestoreAssitant.sendApointmentReply(
                                              appointmentReplyData);
                                          Navigator.pop(context);
                                        }),
                                    // ignore: deprecated_member_use
                                    FlatButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        })
                                  ],
                                );
                              });
                        }),
                    // ignore: deprecated_member_use
                    FlatButton(
                        child: Text('No'),
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
                        style: GoogleFonts.rajdhani(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
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
                                        style: GoogleFonts.rajdhani(
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
                                                      'Please Enter the address'),
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
                                          firestoreAssitant.sendApointmentReply(
                                              appointmentReplyData);
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
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
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
        height: size.height * 0.25,
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
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Text(
                    message.name ?? 'No data',
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
                    '  Patient Email:   ',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Text(
                    message.patientEmail ?? 'No data',
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
                        fontWeight: FontWeight.bold),
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
                    '  Appointment Type:   ',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Text(
                    message.appointmenttype ?? 'No data',
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
                        fontWeight: FontWeight.bold),
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
