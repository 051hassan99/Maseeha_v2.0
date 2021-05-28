import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maseeha_update/Assistants/firestore_assitant.dart';
import 'package:maseeha_update/Caretaker/caretakerAppointmentReplyData.dart';
import 'package:maseeha_update/Patient/patientScreensData/loginPatientData.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';

import '../../lang_selector.dart';


class CaretakerAppointmentHistory extends StatelessWidget {
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
              .collection('caretakerAppointmentReply')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            List<CaretakerAppointmentReplyData> appReply = [];
            final currentPatientEmail =
                context.read<LoginPatientData>().getCurrentPatientData();

            for (var reply in snapshot.data.docs) {
              if (currentPatientEmail == reply['patientEmail']) {
                appReply.add(CaretakerAppointmentReplyData.fromJson(reply.data()));
              }
            }

             return ListView.builder(
              itemBuilder: (_, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50.0, vertical: 5),
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
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
                          SizedBox(height: size.height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: size.width * 0.04),
                              Text(
                                "Patient Name",
                                style: TextStyle(
                                  fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                                ),
                              ),
                               SizedBox(width: size.width * 0.12),
                              Text(
                                appReply[index].patientName,
                                style: TextStyle(
                                  fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: size.height * 0.02),
                          FittedBox(
                            fit: BoxFit.contain,
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                 SizedBox(width: size.width * 0.04),
                                Text(
                                  "Message from Doctor",
                                  style: TextStyle(
                                    fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                                  ),
                                ),
                                 SizedBox(width: size.width * 0.04),
                                Text(
                                  appReply[index].appointmentReplyMessage,
                                  style: TextStyle(
                                    fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: size.width * 0.04),
                              Text(
                                "Doctor Name",
                                style: TextStyle(
                                  fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                                ),
                              ),
                               SizedBox(width: size.width * 0.12),
                              Text(
                                appReply[index].caretakerName,
                                style: TextStyle(
                                  fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.02),
                        ],
                      ),
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
