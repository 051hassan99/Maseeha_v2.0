import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maseeha_update/Doctor/loginDoctorData.dart';
import 'package:maseeha_update/Patient/newAppointmentdata.dart';
import 'package:maseeha_update/current_user.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';
import '../lang_selector.dart';

class Appointments extends StatelessWidget {
  static const String id = 'appointments_screen';
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
          stream: _firestore.collection('appointments').snapshots(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            List<NewAppointmentData> apps = [];
            // CurrentUser currentDoctor =
            //     context.read<LoginDoctorData>().currentUser;

            for (var appointment in snapshot.data.docs) {
              NewAppointmentData data =
                  NewAppointmentData.fromJson(appointment.data());
              print('Appointment doctor ${data.doctorName}');

              apps.add(NewAppointmentData.fromJson(appointment.data()));
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
