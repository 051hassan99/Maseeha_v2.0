import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maseeha_update/Assistants/firestore_assitant.dart';
import 'package:maseeha_update/Patient/Custodian/localNotificationImplement.dart';
import 'package:maseeha_update/Patient/patientScreensData/loginPatientData.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';
import '../../lang_selector.dart';
import 'addMedicineData.dart';

class AddMedicine extends StatelessWidget {
  final TextEditingController medNameController = new TextEditingController();
  final TextEditingController doseDateController = new TextEditingController();
  final TextEditingController medMsgController = new TextEditingController();
  final TextEditingController doseTimeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final firestoreAssitant = FirestoreAssitant();
    final newMedicineData =
        Provider.of<AddMedicineData>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    final addMedicineData =
        Provider.of<AddMedicineData>(context, listen: false);

    final localNotificationImplement =
        Provider.of<LocalNotificationImplement>(context, listen: false);
    //   Provider.of<LocalNotificationImplement>(context).context = context;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: [
            Container(
              height: size.height * 0.3,
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Text(
                      DemoLocalization.of(context)
                          .getTranslatedValue('addMedicine'),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                          color: Colors.white),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                        right: 10,
                        bottom: 100,
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
                    child: new ListView(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30.0),
                        child: new Form(
                          // ignore: deprecated_member_use
                          autovalidate: false,
                          child: Consumer<AddMedicineData>(
                            builder: (_, addMedicineData, child) {
                              if (addMedicineData.loading) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor,
                                    ),
                                  ),
                                );
                              } else {
                                return child;
                              }
                            },
                            child: SingleChildScrollView(
                              child: new Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: new TextFormField(
                                      controller: medNameController,
                                      decoration: new InputDecoration(
                                          hintText: DemoLocalization.of(context)
                                              .getTranslatedValue('addMedName'),
                                          hintStyle: TextStyle(
                                              fontSize: 14,
                                              fontFamily:
                                                  'Jameel Noori Nastaleeq Kasheeda'),
                                          filled: false,
                                          prefixIcon: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 7.0),
                                              child: Icon(Icons
                                                  .medical_services_outlined))),
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (String value) {
                                        localNotificationImplement.title =
                                            value;
                                        addMedicineData.medName = value;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0, right: 10.0, top: 5.0),
                                      child: new TextFormField(
                                        controller: medMsgController,
                                        decoration: new InputDecoration(
                                            hintText:
                                                DemoLocalization.of(context)
                                                    .getTranslatedValue(
                                                        'addSomeIntructions'),
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontFamily:
                                                    'Jameel Noori Nastaleeq Kasheeda'),
                                            enabled: true,
                                            filled: false,
                                            prefixIcon: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 7.0),
                                              child: Icon(Icons.pages_outlined),
                                            )),
                                        onChanged: (String value) {
                                          localNotificationImplement.body =
                                              value;
                                          addMedicineData.medDescription =
                                              value;
                                        },
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0, right: 10.0, top: 5.0),
                                      child: new TextFormField(
                                        controller: doseDateController,
                                        decoration: new InputDecoration(
                                            hintText:
                                                DemoLocalization.of(context)
                                                    .getTranslatedValue(
                                                        'addMedDate'),
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontFamily:
                                                    'Jameel Noori Nastaleeq Kasheeda'),
                                            enabled: true,
                                            filled: false,
                                            prefixIcon: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 7.0),
                                              child: Icon(Icons.pages_outlined),
                                            )),
                                        onChanged: (String value) {
                                          localNotificationImplement.date =
                                              value;
                                          addMedicineData.date = value;
                                        },
                                      )),
                                  SizedBox(height: 10),
                                  new Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0, right: 10.0, top: 5.0),
                                    child: new TextFormField(
                                      controller: doseTimeController,
                                      decoration: new InputDecoration(
                                          hintText: DemoLocalization.of(context)
                                              .getTranslatedValue('addMedTime'),
                                          hintStyle: TextStyle(
                                              fontSize: 13,
                                              fontFamily:
                                                  'Jameel Noori Nastaleeq Kasheeda'),
                                          enabled: true,
                                          filled: false,
                                          prefixIcon: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 7.0),
                                              child:
                                                  Icon(Icons.time_to_leave))),
                                      onChanged: (String value) {
                                        localNotificationImplement.time = value;
                                        addMedicineData.time = value;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  FittedBox(
                                    fit: BoxFit.contain,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 0.0,
                                              top: 45.0,
                                              bottom: 20.0),
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                bottom: size.height / 14),
                                            padding: EdgeInsets.all(8),
                                            width: size.width / 2,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(80),
                                            ),
                                            // ignore: deprecated_member_use
                                            child: new FlatButton(
                                                splashColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                child: Text(
                                                  DemoLocalization.of(context)
                                                      .getTranslatedValue(
                                                          'addMedicine'),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                      fontFamily:
                                                          'Jameel Noori Nastaleeq Kasheeda',
                                                      color: Colors.white),
                                                ),
                                                onPressed: () async {
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
                                                  } else if (!(medMsgController
                                                          .value.text
                                                          .toString()
                                                          .trim()
                                                          .length >
                                                      0)) {
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          "Please enter the medicine description.",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                    );
                                                  } else if (!(doseDateController
                                                          .value.text
                                                          .toString()
                                                          .trim()
                                                          .length >
                                                      0)) {
                                                    Fluttertoast.showToast(
                                                      msg:
                                                          "Please enter the date ",
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
                                                    //   final progress = ProgressHUD.of(context);
                                                    //   progress?.show();
                                                    print('Uploading data');
                                                    addMedicineData
                                                        .toggleLoading();
                                                    localNotificationImplement
                                                        .timeConvert();

                                                    localNotificationImplement
                                                        .mergeTimeAndDate();

                                                    medNameController.clear();
                                                    medMsgController.clear();
                                                    doseTimeController.clear();
                                                    doseDateController.clear();
                                                    localNotificationImplement
                                                        .intializeSetting();

                                                    localNotificationImplement
                                                        .showNotification();

                                                    await firestoreAssitant
                                                        .sendMedicineData(
                                                            newMedicineData);
                                                    addMedicineData
                                                        .toggleLoading();
                                                    //progress?.dismiss();
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            'You have succesfully added medicine to custodian',
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        backgroundColor:
                                                            Colors.blue,
                                                        textColor:
                                                            Colors.white);
                                                    Navigator.pop(context);
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
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(80),
                                            ),
                                            // ignore: deprecated_member_use
                                            child: new FlatButton(
                                                splashColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                child: Text(
                                                  DemoLocalization.of(context)
                                                      .getTranslatedValue(
                                                          'Cancel'),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      fontFamily:
                                                          'Jameel Noori Nastaleeq Kasheeda',
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
                        ),
                      ),
                    ]),
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
