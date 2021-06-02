import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maseeha_update/Doctor/doctorScreensData/doctorRegisterData.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import '../../lang_selector.dart';
import 'doctor_login.dart';
import 'package:provider/provider.dart';

class DoctorSignup extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final doctorRegisterData =
        Provider.of<DoctorRegisterData>(context, listen: false);

    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: SafeArea(
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
                        DemoLocalization.of(context).getTranslatedValue('d'),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                            fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
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
                    child: Form(
                      key: _formkey,
                      child: Consumer<DoctorRegisterData>(
                        builder: (_, docregisterdata, child) {
                          if (docregisterdata.loading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return child;
                          }
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: size.height / 18,
                                margin: EdgeInsets.symmetric(
                                  vertical: size.height / 50,
                                ),
                                child: Center(
                                  child: Text(
                                    DemoLocalization.of(context)
                                        .getTranslatedValue('stc'),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              InfoEntry(
                                size: size,
                                icon: Icons.account_circle,
                                hintText: 'efullname',
                                validatorText: 'namerequired',
                                onChanged: (String value) {
                                  doctorRegisterData.docName = value;
                                },
                              ),
                              InfoEntry(
                                size: size,
                                icon: Icons.email,
                                hintText: 'eemail',
                                validatorText: 'emailrequired',
                                onChanged: (String value) {
                                  doctorRegisterData.docEmail = value;
                                },
                              ),
                              InfoEntry(
                                size: size,
                                icon: Icons.local_hospital,
                                hintText: 'EnterYourHospital',
                                validatorText: 'hospitalrequired',
                                onChanged: (String value) {
                                  doctorRegisterData.hospital = value;
                                },
                              ),
                              InfoEntry(
                                size: size,
                                icon: Icons.local_hospital,
                                hintText: 'EnterYourPmdcNo',
                                validatorText: 'pmdcrequired',
                                onChanged: (String value) {
                                  doctorRegisterData.pmdc = value;
                                },
                              ),
                              InfoEntry(
                                size: size,
                                icon: Icons.local_hospital,
                                hintText: 'EnterYourSpecialization',
                                validatorText: 'specializationrequired',
                                onChanged: (String value) {
                                  doctorRegisterData.specialiozation = value;
                                },
                              ),
                              PasswordEntry(
                                size: size,
                                icon: Icons.vpn_key,
                                hintText: 'epass',
                                validatorText: 'passwordrequired',
                                onChanged: (value) {
                                  doctorRegisterData.docPassword = value;
                                },
                              ),
                              /* PasswordEntry(
                                size: size,
                                icon: Icons.vpn_key,
                                hintText: 'econfirmpass',
                                validatorText: 'confirmpassrequired',
                                onChanged: (String value) {
                                  doctorRegisterData.docConfirmPass = value;
                                },
                              ), */
                              FittedBox(
                                fit: BoxFit.contain,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                            left: 20,
                                          ),
                                          width: (size.width) / 3,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(80),
                                          ),
                                          // ignore: deprecated_member_use
                                          child: FlatButton(
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              child: Text(
                                                DemoLocalization.of(context)
                                                    .getTranslatedValue(
                                                        'signup'),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        'Jameel Noori Nastaleeq Kasheeda',
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () async {
                                                /*  if (!_formkey.currentState
                                                  .validate()) {
                                                return;
                                              } else {
                                                print('here on connect!')};*/

                                                final isDoctor =
                                                    await doctorRegisterData
                                                        .appConnect();
                                                if (isDoctor) {
                                                  print('DOCTOR IS AUTHENTICATED SUCCESFULLY');

                                             /*     final variable = await Provider
                                                          .of<DoctorRegisterData>(
                                                              context,
                                                              listen: false)
                                                      .registerUser();

                                                  if (variable && isDoctor) {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            'You have succesfully signed up',
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        backgroundColor:
                                                            Colors.blue,
                                                        textColor:
                                                            Colors.white);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DoctorLogin()),
                                                    );
                                                  }

                                                  print(context
                                                      .read<
                                                          DoctorRegisterData>()
                                                      .docName);
                                                  print(context
                                                      .read<
                                                          DoctorRegisterData>()
                                                      .docEmail); */
                                                }
                                              })),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 10,
                                          right: 20,
                                        ),
                                        width: ((size.width) * 1.5) / 3,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(80),
                                        ),
                                        // ignore: deprecated_member_use
                                        child: FlatButton(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            child: Text(
                                              DemoLocalization.of(context)
                                                  .getTranslatedValue(
                                                      'backtologin'),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  fontFamily:
                                                      'Jameel Noori Nastaleeq Kasheeda',
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DoctorLogin()),
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                             
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordEntry extends StatelessWidget {
  const PasswordEntry({
    Key key,
    @required this.size,
    @required this.icon,
    @required this.hintText,
    @required this.validatorText,
    @required this.onChanged,
  }) : super(key: key);

  final Size size;
  final IconData icon;
  final String hintText;
  final String validatorText;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          borderRadius: BorderRadius.circular(60),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              child: Icon(
                this.icon,
                size: 25,
                color: Color(0xFFBB9B9B9),
              ),
            ),
            Expanded(
              child: Consumer<DoctorRegisterData>(
                builder: (context, docregdata, _) {
                  return TextFormField(
                      decoration: InputDecoration(
                        hintText: DemoLocalization.of(context)
                            .getTranslatedValue(this.hintText),
                        hintStyle: TextStyle(
                          fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: Color(0xFFBB9B9B9),
                          ),
                          onPressed: () {
                            docregdata.secureText();
                          },
                        ),
                      ),
                      obscureText: docregdata.securetext,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return DemoLocalization.of(context)
                              .getTranslatedValue(this.validatorText);
                        }
                        return null;
                      },
                      onChanged: this.onChanged);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoEntry extends StatelessWidget {
  const InfoEntry({
    Key key,
    @required this.size,
    @required this.hintText,
    @required this.validatorText,
    @required this.icon,
    @required this.onChanged,
    this.isEmail = true,
  }) : super(key: key);

  final Size size;
  final String hintText;
  final String validatorText;
  final IconData icon;
  final Function onChanged;
  final bool isEmail;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                this.icon,
                size: 25,
                color: Color(0xFFBB9B9B9),
              ),
            ),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: DemoLocalization.of(context)
                      .getTranslatedValue(this.hintText),
                   hintStyle: TextStyle(
                          fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                        ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return DemoLocalization.of(context)
                        .getTranslatedValue(this.validatorText);
                  }
                  if (isEmail &&
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return DemoLocalization.of(context)
                        .getTranslatedValue('entervalidemail');
                  }

                  return null;
                },
                onChanged: this.onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
