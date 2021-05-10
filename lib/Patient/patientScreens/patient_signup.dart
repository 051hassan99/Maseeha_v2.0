import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maseeha_update/Patient/patientScreensData/AppUserData.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';
import '../../lang_selector.dart';
import 'patient_login.dart';

class PatientSignUp extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final patientdata = Provider.of<AppUserData>(context, listen: false);
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
                        DemoLocalization.of(context).getTranslatedValue('p'),
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
                      child: Consumer<AppUserData>(
                        builder: (_, appuserdata, child) {
                          if (appuserdata.loading) {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor,
                                ),
                              ),
                            );
                          } else {
                            return child;
                          }
                        },
                        child: SingleChildScrollView(
                          child: Column(children: [
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
                                    fontFamily:
                                        'Jameel Noori Nastaleeq Kasheeda',
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width / 9),
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
                                              hintText:
                                                  DemoLocalization.of(context)
                                                      .getTranslatedValue(
                                                          'efullname'),
                                              hintStyle: TextStyle(
                                                fontFamily:
                                                    'Jameel Noori Nastaleeq Kasheeda',
                                              ),
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.all(10),
                                            ),
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                return DemoLocalization.of(
                                                        context)
                                                    .getTranslatedValue(
                                                        'namerequired');
                                              }
                                              return null;
                                            },
                                            onChanged: (String value) {
                                              patientdata.name = value;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width / 9),
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
                                            Icons.email,
                                            size: 25,
                                            color: Color(0xFFBB9B9B9),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              hintText: DemoLocalization.of(
                                                      context)
                                                  .getTranslatedValue('eemail'),
                                              hintStyle: TextStyle(
                                                fontFamily:
                                                    'Jameel Noori Nastaleeq Kasheeda',
                                              ),
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.all(10),
                                            ),
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                return DemoLocalization.of(
                                                        context)
                                                    .getTranslatedValue(
                                                        'emailrequired');
                                              }
                                              if (!RegExp(
                                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                  .hasMatch(value)) {
                                                return DemoLocalization.of(
                                                        context)
                                                    .getTranslatedValue(
                                                        'entervalidemail');
                                              }
                                              return null;
                                            },
                                            onChanged: (String value) {
                                              patientdata.email = value;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width / 9),
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
                                            Icons.home,
                                            size: 25,
                                            color: Color(0xFFBB9B9B9),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              hintText:
                                                  DemoLocalization.of(context)
                                                      .getTranslatedValue(
                                                          'eaddress'),
                                              hintStyle: TextStyle(
                                                fontFamily:
                                                    'Jameel Noori Nastaleeq Kasheeda',
                                              ),
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.all(10),
                                            ),
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                return DemoLocalization.of(
                                                        context)
                                                    .getTranslatedValue(
                                                        'addressrequired');
                                              }
                                              return null;
                                            },
                                            onChanged: (String value) {
                                              patientdata.address = value;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width / 9),
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
                                            Icons.home,
                                            size: 25,
                                            color: Color(0xFFBB9B9B9),
                                          ),
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              hintText: "Enter Your CNIC",
                                              hintStyle: TextStyle(
                                                fontFamily:
                                                    'Jameel Noori Nastaleeq Kasheeda',
                                              ),
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.all(10),
                                            ),
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                return DemoLocalization.of(
                                                        context)
                                                    .getTranslatedValue(
                                                        'addressrequired');
                                              }
                                              return null;
                                            },
                                            onChanged: (String value) {
                                              patientdata.cnic = value;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width / 9),
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
                                            Icons.vpn_key,
                                            size: 25,
                                            color: Color(0xFFBB9B9B9),
                                          ),
                                        ),
                                        Expanded(
                                          child: Consumer<AppUserData>(
                                            builder: (context, appdata, _) {
                                              return TextFormField(
                                                decoration: InputDecoration(
                                                  hintText: DemoLocalization.of(
                                                          context)
                                                      .getTranslatedValue(
                                                          'epass'),
                                                  hintStyle: TextStyle(
                                                    fontFamily:
                                                        'Jameel Noori Nastaleeq Kasheeda',
                                                  ),
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.all(10),
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      Icons.remove_red_eye,
                                                      color: Color(0xFFBB9B9B9),
                                                    ),
                                                    onPressed: () {
                                                      appdata.secureText();
                                                    },
                                                  ),
                                                ),
                                                obscureText: appdata.securetext,
                                                validator: (String value) {
                                                  if (value.isEmpty) {
                                                    return DemoLocalization.of(
                                                            context)
                                                        .getTranslatedValue(
                                                            'passwordrequired');
                                                  }
                                                  return null;
                                                },
                                                onChanged: (value) {
                                                  patientdata.password = value;
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width / 9),
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
                                            Icons.vpn_key,
                                            size: 25,
                                            color: Color(0xFFBB9B9B9),
                                          ),
                                        ),
                                        Expanded(
                                          child: Consumer<AppUserData>(
                                            builder: (context, appuserdata, _) {
                                              return TextFormField(
                                                decoration: InputDecoration(
                                                  hintText: DemoLocalization.of(
                                                          context)
                                                      .getTranslatedValue(
                                                          'econfirmpass'),
                                                  hintStyle: TextStyle(
                                                    fontFamily:
                                                        'Jameel Noori Nastaleeq Kasheeda',
                                                  ),
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          top: 14, left: 4),
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      Icons.remove_red_eye,
                                                      color: Color(0xFFBB9B9B9),
                                                    ),
                                                    onPressed: () {
                                                      appuserdata.secureText();
                                                    },
                                                  ),
                                                ),
                                                obscureText:
                                                    appuserdata.securetext,
                                                validator: (String value) {
                                                  if (value.isEmpty) {
                                                    return DemoLocalization.of(
                                                            context)
                                                        .getTranslatedValue(
                                                            'confirmpassrequired');
                                                  } else {
                                                    if (patientdata.password !=
                                                        value) {
                                                      return DemoLocalization
                                                              .of(context)
                                                          .getTranslatedValue(
                                                              'passandconfirmpassmatch');
                                                    }
                                                  }
                                                  return null;
                                                },
                                                onChanged: (String value) {
                                                  patientdata.confirmPass =
                                                      value;
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
                                                    fontSize: 18,
                                                    fontFamily:
                                                        'Jameel Noori Nastaleeq Kasheeda',
                                                    color: Colors.white),
                                              ),
                                              onPressed: () async {
                                                if (!_formkey.currentState
                                                    .validate()) {
                                                  return;
                                                } else {
                                                  _formkey.currentState.save();

                                                  final variable =
                                                      await Provider.of<
                                                                  AppUserData>(
                                                              context,
                                                              listen: false)
                                                          .registerUser();

                                                  if (variable) {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            'You have successfully signed up',
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        backgroundColor:
                                                            Colors.blue,
                                                        textColor:
                                                            Colors.yellow);
                                                    Navigator.of(context)
                                                        .pushReplacement(MaterialPageRoute(
                                                      builder: (context) =>
                                                          PatientLogin(),
                                                    ));
                                                  }
                                                }
                                              }),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            left: 10,
                                            right: 20,
                                          ),
                                          width: ((size.width) * 1.5) / 3,
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
                                                        'backtologin'),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    fontFamily:
                                                        'Jameel Noori Nastaleeq Kasheeda',
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PatientLogin()),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
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
