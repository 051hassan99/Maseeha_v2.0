import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maseeha_update/Assistants/firestore_assitant.dart';
import 'package:maseeha_update/Patient/loginPatientData.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';

import '../lang_selector.dart';
import 'addMedicineData.dart';

class AddMedicine extends StatelessWidget {
  final TextEditingController medNameController = new TextEditingController();
  final TextEditingController medQuantityController =
      new TextEditingController();
  final TextEditingController medTotalQuantityController =
      new TextEditingController();
  final TextEditingController doseTimeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final firestoreAssitant = FirestoreAssitant();
    final newMedicineData =
        Provider.of<AddMedicineData>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    final addMedicineData =
        Provider.of<AddMedicineData>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: [
            Container(
              height: (size.height * 2.5) / 10,
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Text(
                      DemoLocalization.of(context)
                          .getTranslatedValue('addMedicine'),
                      style: GoogleFonts.rajdhani(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                        right: 10,
                        bottom: 80,
                      ),
                      child: LangSelector()),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: (size.height * 7) / 10,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(80.0),
                      topRight: Radius.circular(80.0),
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30.0,
                  ),
                  child: new Center(
                    child: new Center(
                      child: new ListView(children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 30.0, right: 30.0),
                          child: new Form(
                            autovalidate: false,
                            child: new Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Padding(
                                  padding:
                                      EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: new TextFormField(
                                    controller: medNameController,
                                    decoration: new InputDecoration(
                                        labelText: DemoLocalization.of(context)
                                            .getTranslatedValue('addMedName'),
                                        filled: false,
                                        prefixIcon: Padding(
                                            padding:
                                                EdgeInsets.only(right: 7.0),
                                            child: Icon(Icons
                                                .medical_services_outlined))),
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (String value) {
                                      addMedicineData.medName = value;
                                    },
                                  ),
                                ),
                                SizedBox(height: 5),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0, right: 10.0, top: 5.0),
                                    child: new TextFormField(
                                      obscureText: false,
                                      controller: medQuantityController,
                                      decoration: new InputDecoration(
                                        labelText: DemoLocalization.of(context)
                                            .getTranslatedValue(
                                                'addMedQuantity'),
                                        enabled: true,
                                        filled: false,
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.only(right: 7.0),
                                          child: new Icon(
                                              Icons.format_list_numbered),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      onChanged: (String value) {
                                        addMedicineData.medQuantity =
                                            int.parse(value);
                                      },
                                    )),
                                SizedBox(height: 5),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0, right: 10.0, top: 5.0),
                                    child: new TextFormField(
                                      obscureText: true,
                                      controller: medTotalQuantityController,
                                      decoration: new InputDecoration(
                                          labelText:
                                              DemoLocalization.of(context)
                                                  .getTranslatedValue(
                                                      'addTotalMedQuantity'),
                                          enabled: true,
                                          filled: false,
                                          prefixIcon: Padding(
                                            padding:
                                                EdgeInsets.only(right: 7.0),
                                            child: Icon(Icons.pages_outlined),
                                          )),
                                      keyboardType: TextInputType.number,
                                      onChanged: (String value) {
                                        addMedicineData.medTotalQuantity =
                                            int.parse(value);
                                      },
                                    )),
                                SizedBox(height: 5),
                                new Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.0, right: 10.0, top: 5.0),
                                  child: new TextFormField(
                                    obscureText: true,
                                    controller: doseTimeController,
                                    decoration: new InputDecoration(
                                        labelText: DemoLocalization.of(context)
                                            .getTranslatedValue('addMedTime'),
                                        enabled: true,
                                        filled: false,
                                        prefixIcon: Padding(
                                            padding:
                                                EdgeInsets.only(right: 7.0),
                                            child: Icon(Icons.time_to_leave))),
                                    keyboardType: TextInputType.datetime,
                                    onChanged: (String value) {
                                      addMedicineData.time = value;

                                      print(
                                          'Time Medicine ${addMedicineData.time}');
                                    },
                                  ),
                                ),
                                SizedBox(height: 5),
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 0.0, top: 45.0, bottom: 20.0),
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              bottom: size.height / 14),
                                          padding: EdgeInsets.all(8),
                                          width: size.width / 2,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(80),
                                          ),
                                          child: new FlatButton(
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              child: Text(
                                                DemoLocalization.of(context)
                                                    .getTranslatedValue(
                                                        'addMedicine'),
                                                style: GoogleFonts.rajdhani(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                if (!(medNameController
                                                        .value.text
                                                        .toString()
                                                        .trim()
                                                        .length >
                                                    0)) {
                                                  Fluttertoast.showToast(
                                                    msg:
                                                        "Please enter Medicine Name.",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                  );
                                                } else if (!(medQuantityController
                                                        .value.text
                                                        .toString()
                                                        .trim()
                                                        .length >
                                                    0)) {
                                                  Fluttertoast.showToast(
                                                    msg:
                                                        "Please enter the medicine quantity.",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                  );
                                                } else if (!(medTotalQuantityController
                                                        .value.text
                                                        .toString()
                                                        .trim()
                                                        .length >
                                                    0)) {
                                                  Fluttertoast.showToast(
                                                    msg:
                                                        "Please enter the total medicine quantity ",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                  );
                                                } else if (!(doseTimeController
                                                        .value.text
                                                        .toString()
                                                        .trim()
                                                        .length >
                                                    0)) {
                                                  Fluttertoast.showToast(
                                                    msg:
                                                        "Please enter the medicine time ",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                  );
                                                }
                                                final email = context
                                                    .read<LoginPatientData>()
                                                    .getCurrentPatientData();

                                                context
                                                    .read<AddMedicineData>()
                                                    .patientEmail = email;

                                                try {
                                                  print('Uploading data');
                                                  firestoreAssitant
                                                      .sendMedicineData(
                                                          newMedicineData);
                                                } catch (_) {
                                                  print('Failed to upload');
                                                }
                                              }),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.0,
                                            top: 45.0,
                                            bottom: 20.0),
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              bottom: size.height / 14),
                                          padding: EdgeInsets.all(8),
                                          width: size.width / 2,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(80),
                                          ),
                                          child: new FlatButton(
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              child: Text(
                                                "Cancel",
                                                style: GoogleFonts.rajdhani(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {}),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
