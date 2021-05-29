import 'package:flutter/material.dart';
import 'package:maseeha_update/Doctor/doctorScreensData/bmrContainerData.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';

class BMRContainer extends StatelessWidget {
  static final _formkey = GlobalKey<FormState>();
  final _a = TextEditingController();
  final _b = TextEditingController();
  final _c = TextEditingController();
  final _d = TextEditingController();
//
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bmrData = Provider.of<BMRContainerData>(context, listen: false);
    return Form(
      key: _formkey,
      child: SingleChildScrollView(
        child: Column(
          children: [
           
            Padding(
              padding: EdgeInsets.only(
                left: size.width *0.02),
        
              child: Row(
                children: [
                  Consumer<BMRContainerData>(builder: (context, bmrData, _) {
                    return Radio(
                      value: "Male",
                      groupValue: bmrData.gender,
                      onChanged: (value) {
                        bmrData.genderChanged(value);
                        print(bmrData.gender);
                      },
                    );
                  }),
                  Text(  DemoLocalization.of(context)
                          .getTranslatedValue('Male'),
                  style: TextStyle(
                      fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                      fontSize: 14 ),),
                  Consumer<BMRContainerData>(builder: (context, bmrData, _) {
                    return Radio(
                      value: "Female",
                      groupValue: bmrData.gender,
                      onChanged: (value) {
                        bmrData.genderChanged(value);
                        print(bmrData.gender);
                      },
                    );
                  }),
                  Text(  DemoLocalization.of(context)
                          .getTranslatedValue('female'),
                  style: TextStyle(
                      fontFamily: 'Jameel Noori Nastaleeq Kasheeda' ,
                      fontSize: 14),),
                ],
              ),
            ),
             SizedBox(height: size.height * 0.04),
            Container(
              padding: EdgeInsets.all(size.width *0.01),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFBC7C7C7),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: FeetTextField(a: _a, bmrData: bmrData),
                  ),
                  Expanded(
                    child: IncTextField(b: _b, bmrData: bmrData),
                  ),
                ],
              ),
            ),
           SizedBox(height: size.height * 0.04),
            Padding(
               padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.08),
              child: Container(
                 padding: EdgeInsets.all(size.width *0.01),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFBC7C7C7),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: WeightTextField(c: _c, bmrData: bmrData),
                ),
              ),
            ),
             SizedBox(height: size.height * 0.06),
            Padding(
               padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.08),
              child: Container(
               padding: EdgeInsets.all(size.width *0.01),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFBC7C7C7),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: AgeTextField(d: _d, bmrData: bmrData),
                ),
              ),
            ),
           
              SizedBox(height: size.height * 0.06),
            Row(
              children: [
                Container(
                  width: size.width * 0.25,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    child: Text(
                        DemoLocalization.of(context)
                          .getTranslatedValue('Result'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {
                      if (!_formkey.currentState.validate()) {
                        return;
                      } else {
                        _formkey.currentState.save();

                        bmrData.calculateResult();
                      }
                    },
                  ),
                ),
                Expanded(
                  child: Consumer<BMRContainerData>(
                      builder: (context, bmrData, _) {
                    return Container(
                      height: size.width * 0.15,
                      width:  size.width * 0.2,
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
                          bmrData.myFinalResult,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                Container(
              
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    child: Text(
                        DemoLocalization.of(context)
                          .getTranslatedValue('Clear'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
                      ),
                    ),
                    onPressed: () {
                      _a.clear();
                      _b.clear();
                      _c.clear();
                      _d.clear();
                      bmrData.clearValues();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AgeTextField extends StatefulWidget {
  const AgeTextField({
    Key key,
    @required TextEditingController d,
    @required this.bmrData,
  }) : _d = d, super(key: key);

  final TextEditingController _d;
  final BMRContainerData bmrData;

  @override
  _AgeTextFieldState createState() => _AgeTextFieldState();
}

class _AgeTextFieldState extends State<AgeTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._d,
      decoration: InputDecoration(
        hintText: DemoLocalization.of(context)
            .getTranslatedValue('age'),
          hintStyle: TextStyle(
            fontSize: 14,
            fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
          ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(10),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return DemoLocalization.of(context)
              .getTranslatedValue('age');
        }
        return null;
      },
      onChanged: (String value) {
        widget.bmrData.age = int.parse(value);
      },
    );
  }
}

class WeightTextField extends StatefulWidget {
  const WeightTextField({
    Key key,
    @required TextEditingController c,
    @required this.bmrData,
  }) : _c = c, super(key: key);

  final TextEditingController _c;
  final BMRContainerData bmrData;

  @override
  _WeightTextFieldState createState() => _WeightTextFieldState();
}

class _WeightTextFieldState extends State<WeightTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._c,
      decoration: InputDecoration(
        hintText: DemoLocalization.of(context)
            .getTranslatedValue('mass'),
          hintStyle: TextStyle(
            fontSize: 14,
            fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
          ),
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
        widget.bmrData.mass = double.parse(value);
      },
    );
  }
}

class IncTextField extends StatefulWidget {
  const IncTextField({
    Key key,
    @required TextEditingController b,
    @required this.bmrData,
  }) : _b = b, super(key: key);

  final TextEditingController _b;
  final BMRContainerData bmrData;

  @override
  _IncTextFieldState createState() => _IncTextFieldState();
}

class _IncTextFieldState extends State<IncTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._b,
      decoration: InputDecoration(
        hintText: DemoLocalization.of(context)
            .getTranslatedValue('HeightInInc'),
          hintStyle: TextStyle(
            fontSize: 14,
            fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
          ),
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
        widget.bmrData.inch = int.parse(value);
      },
    );
  }
}

class FeetTextField extends StatefulWidget {
  const FeetTextField({
    Key key,
    @required TextEditingController a,
    @required this.bmrData,
  }) : _a = a, super(key: key);

  final TextEditingController _a;
  final BMRContainerData bmrData;

  @override
  _FeetTextFieldState createState() => _FeetTextFieldState();
}

class _FeetTextFieldState extends State<FeetTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._a,
      decoration: InputDecoration(
        hintText: DemoLocalization.of(context)
            .getTranslatedValue('HeightInFeet'),
          hintStyle: TextStyle(
            fontSize: 14,
            fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
          ),
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
        widget.bmrData.feet = int.parse(value);
      },
    );
  }
}
