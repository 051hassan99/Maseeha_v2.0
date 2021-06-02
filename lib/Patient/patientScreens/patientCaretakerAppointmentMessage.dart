import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maseeha_update/Assistants/firestore_assitant.dart';
import 'package:maseeha_update/Patient/patientScreensData/loginPatientData.dart';
import 'package:maseeha_update/caretaker/caretakerAppointmentReplyData.dart';
import 'package:maseeha_update/classes/review.dart';
import 'package:maseeha_update/feedback.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';

import '../../lang_selector.dart';

class CaretakerAppointmentHistory extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final firestoreAssitant = FirestoreAssitant();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
     final reviewData =
        Provider.of<Review>(context, listen: false);

    void giveFeedback(BuildContext context) => showDialog(
        context: context,
        builder: (_) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: Container(
                child: Center(
                  child: Text(
                    DemoLocalization.of(context)
                              .getTranslatedValue('ReviewSection'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              content: UserFeedback(),
              actions: [
                // ignore: deprecated_member_use
                FlatButton(
                  child: Text(
                    DemoLocalization.of(context).getTranslatedValue('submit'),
                    style: TextStyle(
                      fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async{
                      await firestoreAssitant.sendReview(reviewData);
                      Fluttertoast.showToast(
                                                    msg:
                                                        'You have succesfully reviewed',
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    backgroundColor:
                                                        Colors.blue,
                                                    textColor: Colors.white);
                      Navigator.pop(context);
                  },
                ),
                 // ignore: deprecated_member_use
                 FlatButton(
                  child: Text(
                    DemoLocalization.of(context).getTranslatedValue('Cancel'),
                    style: TextStyle(
                      fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
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
                        fontFamily: 'Jameel Noori Nastaleeq Kasheeda'),
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
                appReply
                    .add(CaretakerAppointmentReplyData.fromJson(reply.data()));
              }
            }

            return ListView.builder(
              itemBuilder: (_, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50.0, vertical: 5),
                  child: GestureDetector(
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
                                   DemoLocalization.of(context).getTranslatedValue('PatientName'),
                                  style: TextStyle(
                                    fontFamily:
                                        'Jameel Noori Nastaleeq Kasheeda',
                                  ),
                                ),
                                SizedBox(width: size.width * 0.12),
                                Text(
                                  appReply[index].patientName,
                                  style: TextStyle(
                                    fontFamily:
                                        'Jameel Noori Nastaleeq Kasheeda',
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
                                     DemoLocalization.of(context).getTranslatedValue('MessageFromCaretaker'),
                                    style: TextStyle(
                                      fontFamily:
                                          'Jameel Noori Nastaleeq Kasheeda',
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.04),
                                  Text(
                                    appReply[index].appointmentReplyMessage,
                                    style: TextStyle(
                                      fontFamily:
                                          'Jameel Noori Nastaleeq Kasheeda',
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
                                   DemoLocalization.of(context).getTranslatedValue('CaretakerName'),
                                  style: TextStyle(
                                    fontFamily:
                                        'Jameel Noori Nastaleeq Kasheeda',
                                  ),
                                ),
                                SizedBox(width: size.width * 0.12),
                                Text(
                                  appReply[index].caretakerName,
                                  style: TextStyle(
                                    fontFamily:
                                        'Jameel Noori Nastaleeq Kasheeda',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.02),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      giveFeedback(context);
                    },
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
