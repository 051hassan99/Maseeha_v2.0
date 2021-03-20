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

    return ListView(
      children: [
        Container(
          height: size.height / 15,
          margin: EdgeInsets.symmetric(
            vertical: size.height / 35,
          ),
          child: Center(
            child: Text(
              DemoLocalization.of(context).getTranslatedValue('fillform'),
              style: GoogleFonts.rajdhani(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width / 4.5,
          ),
          child: Text(
            DemoLocalization.of(context).getTranslatedValue('gender'),
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width / 5,
          ),
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
              Text('Male'),
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
              Text('Female'),
            ],
          ),
        ),
        SizedBox(height: size.height / 50),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width / 4.5,
          ),
          child: Text(
            DemoLocalization.of(context).getTranslatedValue('appointmenttype'),
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width / 5,
          ),
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
              Text('Physical'),
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
              Text('Online'),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width / 9),
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(4),
            width: 300,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFFBC7C7C7),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  child: Icon(
                    Icons.account_circle,
                    size: 25,
                    color: Color(0xFFBB9B9B9),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: DemoLocalization.of(context)
                          .getTranslatedValue('efullname'),
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
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width / 9),
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(4),
            width: 300,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFFBC7C7C7),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  child: Icon(
                    Icons.confirmation_number,
                    size: 25,
                    color: Color(0xFFBB9B9B9),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: DemoLocalization.of(context)
                          .getTranslatedValue('age'),
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
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width / 9),
          child: Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(4),
            width: 300,
            height: 100,
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
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
                onChanged: (value) {
                  newApponitmentData.diseaseDescription = value;
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width / 3,
          ),
          child: Container(
            width: 10,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Text(
                  DemoLocalization.of(context).getTranslatedValue('signin'),
                  style: GoogleFonts.rajdhani(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                onPressed: () async {
                  try {
                    print('Uploading data');
                    firestoreAssitant.sendAppointment(newApponitmentData);
                  } catch (_) {
                    print('Failed to upload');
                  }
                }),
          ),
        ),
      ],
    );
  }
}
