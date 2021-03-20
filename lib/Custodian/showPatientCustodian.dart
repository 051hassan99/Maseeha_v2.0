import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maseeha_update/Patient/loginPatientData.dart';
import 'package:maseeha_update/Patient/newAppointmentdata.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';
import '../lang_selector.dart';
import 'addMedicineData.dart';

class ShowPatientCustodian extends StatelessWidget {
  static const String id = 'showPatientCustodian_screen';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
          stream: _firestore.collection('medicines').snapshots(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            List<AddMedicineData> meds = [];
            // CurrentUser currentDoctor =
            //     context.read<LoginDoctorData>().currentUser;

            final email =
                context.read<LoginPatientData>().getCurrentPatientData();

            for (var medicine in snapshot.data.docs) {
              if (email == medicine['PatientEmail']) {
                AddMedicineData data =
                    AddMedicineData.fromMedicineJson(medicine.data());

                meds.add(data);
              }
            }

            return ListView.builder(
              itemBuilder: (_, index) {
                return Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: TextSpan(
                          text: '     Medicine Name:     ',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: meds[index].medName + "     ",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                          text: '     Medicine Quantity:     ',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  meds[index].medQuantity.toString() + "      ",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                          text: '     Total Quantity:     ',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: meds[index].medTotalQuantity.toString() +
                                  "      ",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                          text: '     Time:     ',
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: meds[index].time.toString() + "      ",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                );
              },
              itemCount: meds.length,
            );
          },
        ),
      ),
    );
  }
}
