import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';

import 'bmiContainer_Data.dart';

class BMIContainer extends StatelessWidget {
  static final _formkey = GlobalKey<FormState>();

  final _a = TextEditingController();
  final _b = TextEditingController();
  final _c = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bmiData = Provider.of<BMIContainerData>(context, listen: false);
    return Form(
      key: _formkey,
      child: ListView(
        children: [
          Container(
            height: size.height / 15,
            margin: EdgeInsets.symmetric(
              vertical: size.height / 35,
            ),
            child: Center(
              child: Text(
                DemoLocalization.of(context).getTranslatedValue('BMI'),
                style: GoogleFonts.rajdhani(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Theme.of(context).primaryColor,
                ),
              ),
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
                  Expanded(
                    child: TextFormField(
                      controller: _a,
                      decoration: InputDecoration(
                        hintText: DemoLocalization.of(context)
                            .getTranslatedValue('HeightInFeet'),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return DemoLocalization.of(context)
                              .getTranslatedValue('HeightInFeet');
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        bmiData.feet = int.parse(value);
                      },
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _b,
                      decoration: InputDecoration(
                        hintText: DemoLocalization.of(context)
                            .getTranslatedValue('HeightInInc'),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return DemoLocalization.of(context)
                              .getTranslatedValue('HeightInInc');
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        bmiData.inch = int.parse(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: size.height / 80),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width / 5),
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
              child: Container(
                padding: EdgeInsets.only(
                  left: 20,
                ),
                child: TextFormField(
                  controller: _c,
                  decoration: InputDecoration(
                    hintText:
                        DemoLocalization.of(context).getTranslatedValue('mass'),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return DemoLocalization.of(context)
                          .getTranslatedValue('mass');
                    }
                    return null;
                  },
                  onChanged: (String value) {
                    bmiData.mass = double.parse(value);
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.width / 9, horizontal: size.width / 9),
            child: Row(
              children: [
                Container(
                  width: 100,
                  child: FlatButton(
                    child: Text(
                      'Result',
                      style: GoogleFonts.rajdhani(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {
                      if (!_formkey.currentState.validate()) {
                        return;
                      } else {
                        _formkey.currentState.save();

                        bmiData.finalResult(bmiData.meter, bmiData.mass);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: Consumer<BMIContainerData>(
                      builder: (context, bmiData, _) {
                    return Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        border: Border.all(
                          color: Color(0xFFBC7C7C7),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          bmiData.myFinalResult,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                Container(
                  width: 100,
                  child: FlatButton(
                    child: Text(
                      'Clear',
                      style: GoogleFonts.rajdhani(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {
                      _a.clear();
                      _b.clear();
                      _c.clear();
                      bmiData.clearValues();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
