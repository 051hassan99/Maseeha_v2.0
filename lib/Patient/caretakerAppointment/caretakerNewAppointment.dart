import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maseeha_update/Assistants/firestore_assitant.dart';
import 'package:maseeha_update/Patient/caretakerAppointment/caretakerNewAppointmentData.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';

class CaretakerNewAppointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final firestoreAssitant = FirestoreAssitant();
    final caretakerAppointmentData =
        Provider.of<CaretakerNewAppointmentData>(context, listen: false);

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
              Consumer<CaretakerNewAppointmentData>(
                  builder: (context, caretakerNewAppointmentData, _) {
                return Radio(
                  value: "Male",
                  groupValue: caretakerNewAppointmentData.gender,
                  onChanged: (value) {
                    caretakerNewAppointmentData.genderChanged(value);
                    print(caretakerNewAppointmentData.gender);
                  },
                );
              }),
              Text('Male'),
              Consumer<CaretakerNewAppointmentData>(
                  builder: (context, caretakerNewAppointmentData, _) {
                return Radio(
                  value: "Female",
                  groupValue: caretakerNewAppointmentData.gender,
                  onChanged: (value) {
                    caretakerNewAppointmentData.genderChanged(value);
                  },
                );
              }),
              Text('Female'),
            ],
          ),
        ),
        SizedBox(height: size.height / 50),
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
                      caretakerAppointmentData.name = value;
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
                      caretakerAppointmentData.age = int.parse(value);
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
                  caretakerAppointmentData.diseaseDescription = value;
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
            // ignore: deprecated_member_use
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
                    firestoreAssitant
                        .sendCaretakerAppointment(caretakerAppointmentData);
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
