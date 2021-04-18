import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maseeha_update/Assistants/firestore_assitant.dart';
import 'package:maseeha_update/Doctor/appointmentReply/appointmentReply.dart';
import 'package:maseeha_update/Doctor/doctorRegisterData.dart';
import 'package:maseeha_update/Patient/newAppointmentdata.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';
import '../lang_selector.dart';

class Appointments extends StatelessWidget {
  static const String id = 'appointments_screen';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
                                    FlatButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        })
                                  ],
                                );
                              });
                        }),
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
                                    FlatButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ],
                                );
                              });
                        }),
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
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('appointments')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            List<NewAppointmentData> apps = [];
            final currentDocEmail =
                context.read<DoctorRegisterData>().getCurrentDoctorData();

            for (var appointment in snapshot.data.docs) {
              if (currentDocEmail == appointment['docEmail']) {
                NewAppointmentData data =
                    NewAppointmentData.fromJson(appointment.data());

                apps.add(NewAppointmentData.fromJson(appointment.data()));
              }
            }

            return ListView.builder(
              itemBuilder: (_, index) {
                final patientAppointmentType = apps[index].appointmenttype;
                final patientEmail = apps[index].patientEmail;
                final patientName = apps[index].name;
                final doctorName = apps[index].doctorName;
                final doctorEmail = apps[index].docEmail;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50.0, vertical: 5),
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 6.0,
                            offset: Offset(0.7, 0.7),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          RichText(
                            text: TextSpan(
                              text: 'Patient name:    ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                color: Colors.red,
                              ),
                              children: [
                                TextSpan(
                                  text: apps[index].name,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          RichText(
                            text: TextSpan(
                              text: 'Patient Gender:   ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                color: Colors.red,
                              ),
                              children: [
                                TextSpan(
                                  text: apps[index].gender,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          RichText(
                            text: TextSpan(
                              text: 'Patient Age:   ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                color: Colors.red,
                              ),
                              children: [
                                TextSpan(
                                  text: apps[index].age.toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          RichText(
                            text: TextSpan(
                              text: 'Patient Disease:   ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                                color: Colors.red,
                              ),
                              children: [
                                TextSpan(
                                  text: apps[index].diseaseDescription,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                    onTap: () {
                      /* print('APPOINTMENT TYPE: ' + patientAppointmentType);
                      print('PATIENT EMAIL: ' + patientEmail);
                      print('DOCTOR NAME: ' + doctorName);
                      print('DOCTOR EMAIL: ' + doctorEmail);  */
                      appointmentMessageReply(context, doctorName, doctorEmail,
                          patientName, patientEmail, patientAppointmentType);
                    },
                  ),
                );
              },
              itemCount: apps.length,
            );
          },
        ),
      ),
    );
  }
}
