import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maseeha_update/Assistants/firestore_assitant.dart';
import 'package:maseeha_update/Doctor/appointmentReply/appointmentReply.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';
import '../lang_selector.dart';
import 'loginPatientData.dart';

class AppointmentHistory extends StatelessWidget {
  static const String id = 'appointments_screen';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final firestoreAssitant = FirestoreAssitant();

  @override
  Widget build(BuildContext context) {
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
              .collection('appointmentReply')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            List<AppointmentReply> appReply = [];
            final currentPatientEmail =
                context.read<LoginPatientData>().getCurrentPatientData();

            for (var reply in snapshot.data.docs) {
              if (currentPatientEmail == reply['patientEmail']) {
                appReply.add(AppointmentReply.fromJson(reply.data()));
              }
            }

            return ListView.builder(
              itemBuilder: (_, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50.0, vertical: 5),
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
                                text: appReply[index].patientName,
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
                            text: 'Message form Doctor:   ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.red,
                            ),
                            children: [
                              TextSpan(
                                text: appReply[index].appointmentReplyMessage,
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
                            text: 'Doctor Name:   ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.red,
                            ),
                            children: [
                              TextSpan(
                                text: appReply[index].docName,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                );
              },
              itemCount: appReply.length,
            );
          },
        ),
      ),
    );
  }
}
