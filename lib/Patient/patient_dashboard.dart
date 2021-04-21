import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maseeha_update/Custodian/patientCustodianSelection.dart';
import 'package:maseeha_update/Doctor/apointment_messages.dart';
import 'package:maseeha_update/Patient/appointmentselction.dart';
import 'package:maseeha_update/Patient/mapbuilding.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:maseeha_update/videoCalling/src/pages/index.dart';

import '../lang_selector.dart';

class PatientDashboard extends StatelessWidget {
  static const String id = 'patient_dashboard';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
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
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: size.height / 60,
                    bottom: size.width / 30,
                  ),
                  child: Text(
                    DemoLocalization.of(context)
                        .getTranslatedValue('patientdashboard'),
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AppointmentSelection(),
                          ),
                        );
                      },
                      child: _buildCard(
                        svgPicture: SvgPicture.asset(
                            'assets/images/checkup.svg',
                            semanticsLabel: 'Tablet'),
                        text: Text(
                          DemoLocalization.of(context)
                              .getTranslatedValue('ScheduleAppointment'),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        context: context,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapBuilding(),
                          ),
                        );
                      },
                      child: _buildCard(
                        svgPicture: SvgPicture.asset('assets/images/map.svg',
                            semanticsLabel: 'Tablet'),
                        text: Text(
                          DemoLocalization.of(context)
                              .getTranslatedValue('FindLocation'),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        context: context,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PatientCustodianSelection(),
                          ),
                        );
                      },
                      child: _buildCard(
                        svgPicture: SvgPicture.asset(
                            'assets/images/alarm-clock.svg',
                            semanticsLabel: 'Tablet'),
                        text: Text(
                          DemoLocalization.of(context)
                              .getTranslatedValue('MedicineAlerts'),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        context: context,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IndexPage(),
                          ),
                        );
                      },
                      child: _buildCard(
                        svgPicture: SvgPicture.asset(
                            'assets/images/computer.svg',
                            semanticsLabel: 'Tablet'),
                        text: Text(
                          DemoLocalization.of(context)
                              .getTranslatedValue('TeleMedicine'),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        context: context,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: _buildCard(
                        svgPicture: SvgPicture.asset(
                            'assets/images/medicine.svg',
                            semanticsLabel: 'Tablet'),
                        text: Text(
                          DemoLocalization.of(context)
                              .getTranslatedValue('BuyDrugsOnline'),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        context: context,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {},
                      child: _buildCard(
                        svgPicture: SvgPicture.asset(
                            'assets/images/caretaker1.svg',
                            semanticsLabel: 'Tablet'),
                        text: Text(
                          DemoLocalization.of(context)
                              .getTranslatedValue('RequestCaretaker'),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        context: context,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width / 4,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Appointments.id);
                        },
                        child: _buildCard(
                          svgPicture: SvgPicture.asset(
                              'assets/images/article.svg',
                              semanticsLabel: 'Tablet'),
                          text: Text(
                            DemoLocalization.of(context)
                                .getTranslatedValue('healthylifestyle'),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          context: context,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Container _buildCard(
    {final SvgPicture svgPicture, Text text, BuildContext context}) {
  Size size = MediaQuery.of(context).size;
  return Container(
    height: size.height / 3.3,
    width: size.width / 1.8,
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: size.height / 7,
          width: size.width / 4,
          child: svgPicture,
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: text,
        ),
      ],
    ),
  );
}
