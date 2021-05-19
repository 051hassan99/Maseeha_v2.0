import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maseeha_update/Map/userTypeforMap.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:maseeha_update/Assistants/authAssistant.dart' as auth_assistant;
import 'package:provider/provider.dart';

import '../lang_selector.dart';
import 'caretakerRegister.dart';
import 'caretaker_dashboard.dart';
import 'caretaker_signup.dart';
import 'loginCaretakerData.dart';

class CaretakerLogin extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final routeMethod = CaretakerDashboard();

  @override
  Widget build(BuildContext context) {
    /*  createAlertDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                DemoLocalization.of(context)
                    .getTranslatedValue('messagefrommaseeha'),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              content: Text(
                DemoLocalization.of(context)
                    .getTranslatedValue('messagemaseeha'),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            );
          });
    }  */

    final loginCaretakerData =
        Provider.of<LoginCaretakerData>(context, listen: false);
    final userType =
        Provider.of<UserType>(context, listen: false);

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
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
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
                    child: Consumer<LoginCaretakerData>(
                      builder: (_, logincaretakerdata, child) {
                        if (logincaretakerdata.loading) {
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
                      child: ListView(
                        children: [
                          Container(
                            height: size.height / 15,
                            margin: EdgeInsets.symmetric(
                              vertical: size.height / 35,
                            ),
                            child: Center(
                              child: Text(
                                DemoLocalization.of(context)
                                    .getTranslatedValue('ltc'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Theme.of(context).primaryColor,
                                   fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width / 9),
                            child: Container(
                              margin: EdgeInsets.all(15),
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
                                         hintStyle: TextStyle(
                                                  fontSize: 14,
                                                   fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
                                                ),
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
                                        loginCaretakerData.careEmail = value;
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
                              margin: EdgeInsets.all(15),
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
                                            hintText: DemoLocalization.of(
                                                    context)
                                                .getTranslatedValue('epass'),
                                                hintStyle: TextStyle(
                                                  fontSize: 14,
                                                   fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
                                                ),
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
                                                      'passwordrequired');
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            loginCaretakerData.carePassword =
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
                                vertical: size.height / 18,
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
                                    // ignore: deprecated_member_use
                                    child: FlatButton(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: Text(
                                          DemoLocalization.of(context)
                                              .getTranslatedValue('signin'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.white,
                                               fontFamily: 'Jameel Noori Nastaleeq Kasheeda'),
                                        ),
                                        onPressed: () async {
                                          if (!_formkey.currentState
                                              .validate()) {
                                            return;
                                          } else {

                                            _formkey.currentState.save();

                                              final check =
                                                  await loginCaretakerData
                                                      .signUser();
                                                
                                              if(check){

                                             userType.userType = "Caretaker";
                                               auth_assistant.abc
                                                    .addUserdata();
                                                Fluttertoast.showToast(
                                                    msg:
                                                        'You have logged in succesfully',
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    backgroundColor:
                                                        Colors.blue,
                                                    textColor: Colors.yellow);

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CaretakerDashboard()),
                                            );
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
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(80),
                                    ),
                                    // ignore: deprecated_member_use
                                    child: FlatButton(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: Text(
                                          DemoLocalization.of(context)
                                              .getTranslatedValue('newmember'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.white,
                                               fontFamily: 'Jameel Noori Nastaleeq Kasheeda'),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(routeMethod.createRoute(CaretakerSignup()));
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
