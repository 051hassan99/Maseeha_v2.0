import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';

import '../lang_selector.dart';
import 'caretakerRegister.dart';
import 'caretaker_login.dart';

class CaretakerSignup extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final caretakerRegisterData =
        Provider.of<CaretakerRegisterData>(context, listen: false);

    Size size = MediaQuery.of(context).size;
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
                      DemoLocalization.of(context).getTranslatedValue('c'),
                      style: GoogleFonts.rajdhani(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
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
                    child: Consumer<CaretakerRegisterData>(
                      builder: (_, careregisterdata, child) {
                        if (careregisterdata.loading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return child;
                        }
                      },
                      child: ListView(
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
                                        hintText: DemoLocalization.of(context)
                                            .getTranslatedValue('efullname'),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return DemoLocalization.of(context)
                                              .getTranslatedValue(
                                                  'namerequired');
                                        }
                                        return null;
                                      },
                                      onChanged: (String value) {
                                        caretakerRegisterData.careName = value;
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
                                        hintText: DemoLocalization.of(context)
                                            .getTranslatedValue('eemail'),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return DemoLocalization.of(context)
                                              .getTranslatedValue(
                                                  'emailrequired');
                                        }
                                        if (!RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(value)) {
                                          return DemoLocalization.of(context)
                                              .getTranslatedValue(
                                                  'entervalidemail');
                                        }
                                        return null;
                                      },
                                      onChanged: (String value) {
                                        caretakerRegisterData.careEmail = value;
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
                                      Icons.local_hospital,
                                      size: 25,
                                      color: Color(0xFFBB9B9B9),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: DemoLocalization.of(context)
                                            .getTranslatedValue(
                                                'EnterYourHospital'),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return DemoLocalization.of(context)
                                              .getTranslatedValue(
                                                  'hospitalrequired');
                                        }
                                        return null;
                                      },
                                      onChanged: (String value) {
                                        caretakerRegisterData.careHospital =
                                            value;
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
                                        hintText: DemoLocalization.of(context)
                                            .getTranslatedValue(
                                                'EnterYourPncNo'),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return DemoLocalization.of(context)
                                              .getTranslatedValue(
                                                  'pncrequired');
                                        }
                                        return null;
                                      },
                                      onChanged: (String value) {
                                        caretakerRegisterData.pnc = value;
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
                                    child: Consumer<CaretakerRegisterData>(
                                      builder: (context, careregdata, _) {
                                        return TextFormField(
                                          decoration: InputDecoration(
                                            hintText: DemoLocalization.of(
                                                    context)
                                                .getTranslatedValue('epass'),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.all(10),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                Icons.remove_red_eye,
                                                color: Color(0xFFBB9B9B9),
                                              ),
                                              onPressed: () {
                                                careregdata.secureText();
                                              },
                                            ),
                                          ),
                                          obscureText: careregdata.securetext,
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
                                            caretakerRegisterData.carePassword =
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
                                    child: Consumer<CaretakerRegisterData>(
                                      builder: (context, caredata, _) {
                                        return TextFormField(
                                          decoration: InputDecoration(
                                            hintText:
                                                DemoLocalization.of(context)
                                                    .getTranslatedValue(
                                                        'econfirmpass'),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.all(10),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                Icons.remove_red_eye,
                                                color: Color(0xFFBB9B9B9),
                                              ),
                                              onPressed: () {
                                                caredata.secureText();
                                              },
                                            ),
                                          ),
                                          obscureText: caredata.securetext,
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return DemoLocalization.of(
                                                      context)
                                                  .getTranslatedValue(
                                                      'confirmpassrequired');
                                            } else {
                                              if (caretakerRegisterData
                                                      .carePassword !=
                                                  value) {
                                                return DemoLocalization.of(
                                                        context)
                                                    .getTranslatedValue(
                                                        'passandconfirmpassmatch');
                                              }
                                            }
                                            return null;
                                          },
                                          onChanged: (String value) {
                                            caretakerRegisterData
                                                .careConfirmPass = value;
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
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(80),
                                    ),
                                    child: FlatButton(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: Text(
                                          DemoLocalization.of(context)
                                              .getTranslatedValue('signup'),
                                          style: GoogleFonts.rajdhani(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                        onPressed: () {
                                          if (!_formkey.currentState
                                              .validate()) {
                                            return;
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
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(80),
                                    ),
                                    child: FlatButton(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: Text(
                                          DemoLocalization.of(context)
                                              .getTranslatedValue(
                                                  'backtologin'),
                                          style: GoogleFonts.rajdhani(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CaretakerLogin()),
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
          ],
        ),
      ),
    );
  }
}
