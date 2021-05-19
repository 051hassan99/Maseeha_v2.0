import 'package:flutter/material.dart';
import 'package:maseeha_update/Patient/caretakerAppointment/caretakerNewAppointmentData.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';

class CaretakerNewAppointment extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   
    final caretakerAppointmentData =
        Provider.of<CaretakerNewAppointmentData>(context, listen: false);

    return SingleChildScrollView(
          child: Container(
            child: Column(
        children: [

            Padding(
                padding: EdgeInsets.only(right: 20.0),
              
              child: Text(
                DemoLocalization.of(context).getTranslatedValue('gender'),
                style: TextStyle(
                 fontSize: 16,
                fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
                ),
              ),
            ),
            Padding(
             padding: EdgeInsets.only(right: 20.0),
              
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
                   Text(
                        DemoLocalization.of(context).getTranslatedValue('Male'),
                        style: TextStyle(
                          fontSize: 12,
                            fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
                        ),
                      ),
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
                  Text(
                         DemoLocalization.of(context).getTranslatedValue('female'),
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
                        ),
                      ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
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
                            hintStyle: TextStyle(fontSize: 14,
                          fontFamily: 'Jameel Noori Nastaleeq Kasheeda'),
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
            Container(
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
                            hintStyle: TextStyle(fontSize: 14,
                          fontFamily: 'Jameel Noori Nastaleeq Kasheeda'),
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

             Container(
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
                      Icons.phone,
                      size: 25,
                      color: Color(0xFFBB9B9B9),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: DemoLocalization.of(context)
                            .getTranslatedValue('age'),
                            hintStyle: TextStyle(fontSize: 14,
                          fontFamily: 'Jameel Noori Nastaleeq Kasheeda'),
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
                        caretakerAppointmentData.phonenumber = value;
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
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFBC7C7C7),
                  width: 2,
                ),
              ),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: DemoLocalization.of(context)
                      .getTranslatedValue('diseasedescription'),
                      hintStyle: TextStyle(fontSize: 14,
                        fontFamily: 'Jameel Noori Nastaleeq Kasheeda'),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
                onChanged: (value) {
                  caretakerAppointmentData.diseaseDescription = value;
                },
              ),
            ),
         
            
        ],
      ),
          ),
    );
  }
}
