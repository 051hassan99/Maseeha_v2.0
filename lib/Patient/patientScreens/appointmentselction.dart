import 'package:flutter/material.dart';
import 'package:maseeha_update/Patient/patientScreens/patientAppointmentMessages.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import '../../category.dart';
import '../../lang_selector.dart';
import 'doctorList.dart';

class AppointmentSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
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
        body: LayoutBuilder(
          builder: (_, constraints) {
            return ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(height: 20),
               
    
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: CategoryButton(
                    imagePath: 'assets/images/doctor.svg',
                    text: 'd',
                    height: constraints.biggest.height * 0.40,
                    width: 10,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorList(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: CategoryButton(
                    imagePath: 'assets/images/appointmentHistory.svg',
                    text: 'appointmentHistory',
                    height: constraints.biggest.height * 0.40,
                    width: 10,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppointmentHistory()),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
