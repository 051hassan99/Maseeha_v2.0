import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:maseeha_update/Assistants/firestore_assitant.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';

import 'newAppointmentdata.dart';

class NewAppointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final firestoreAssitant = FirestoreAssitant();
    final newApponitmentData =
        Provider.of<NewAppointmentData>(context, listen: false);

    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Text(
                DemoLocalization.of(context).getTranslatedValue('gender'),
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Consumer<NewAppointmentData>(
                      builder: (context, newAppointmentData, _) {
                    return Radio(
                      value: "Male",
                      groupValue: newApponitmentData.gender,
                      onChanged: (value) {
                        newApponitmentData.genderChanged(value);
                        print(newApponitmentData.gender);
                      },
                    );
                  }),
                  Text(
                    'Male',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Consumer<NewAppointmentData>(
                      builder: (context, newAppointmentData, _) {
                    return Radio(
                      value: "Female",
                      groupValue: newApponitmentData.gender,
                      onChanged: (value) {
                        newApponitmentData.genderChanged(value);
                        print(newApponitmentData.gender);
                      },
                    );
                  }),
                  Text(
                    'Female',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Text(
                DemoLocalization.of(context)
                    .getTranslatedValue('appointmenttype'),
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Consumer<NewAppointmentData>(
                      builder: (context, newAppointmentData, _) {
                    return Radio(
                      value: "Physical",
                      groupValue: newApponitmentData.appointmenttype,
                      onChanged: (value) {
                        newApponitmentData.apponitmentChanged(value);
                        print(newApponitmentData.appointmenttype);
                      },
                    );
                  }),
                  Text(
                    'Physical',
                    style: TextStyle(fontSize: 12),
                  ),
                  Consumer<NewAppointmentData>(
                      builder: (context, newAppointmentData, _) {
                    return Radio(
                      value: "Online",
                      groupValue: newApponitmentData.appointmenttype,
                      onChanged: (value) {
                        newApponitmentData.apponitmentChanged(value);
                        print(newApponitmentData.appointmenttype);
                      },
                    );
                  }),
                  Text(
                    'Online',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFBC7C7C7),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(80),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    child: Icon(
                      Icons.account_circle,
                      size: 20,
                      color: Color(0xFFBB9B9B9),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: DemoLocalization.of(context)
                            .getTranslatedValue('efullname'),
                        hintStyle: TextStyle(fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return DemoLocalization.of(context)
                              .getTranslatedValue('namerequired');
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        newApponitmentData.name = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFBC7C7C7),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(80),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    child: Icon(
                      Icons.confirmation_number,
                      size: 20,
                      color: Color(0xFFBB9B9B9),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: DemoLocalization.of(context)
                            .getTranslatedValue('age'),
                        hintStyle: TextStyle(fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return DemoLocalization.of(context)
                              .getTranslatedValue('namerequired');
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        newApponitmentData.age = int.parse(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(4),
              width: 300,
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFBC7C7C7),
                  width: 2,
                ),
              ),
              child: Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: DemoLocalization.of(context)
                        .getTranslatedValue('diseasedescription'),
                    hintStyle: TextStyle(fontSize: 12),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8),
                  ),
                  onChanged: (value) {
                    newApponitmentData.diseaseDescription = value;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
