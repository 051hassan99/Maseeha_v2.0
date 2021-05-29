import 'package:flutter/material.dart';
import 'package:maseeha_update/Doctor/doctorScreensData/bmiContainer_Data.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';

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
      child: SingleChildScrollView(
        child: Column(
          children: [
           
            Container(
              padding: EdgeInsets.all(size.width *0.01),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFBC7C7C7),
                
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HeighTextfield(a: _a, bmiData: bmiData),
                  HeightInchTextField(b: _b, bmiData: bmiData),
                ],
              ),
            ),

            SizedBox(height: size.height * 0.06),
       
            Padding(
             padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.08),
              child: Container(
               
                 padding: EdgeInsets.all(size.width *0.01),
  
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFBC7C7C7),
                   
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextFormField(
                  controller: _c,
                  decoration: InputDecoration(
                    hintText: DemoLocalization.of(context)
                        .getTranslatedValue('mass'),
                    hintStyle: TextStyle(
              fontSize: 14,
              fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
          ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      left : 40),
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

                        bmiData.finalResult(bmiData.meter, bmiData.mass);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: Consumer<BMIContainerData>(
                      builder: (context, bmiData, _) {
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
                          bmiData.myFinalResult,
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
                      bmiData.clearValues();
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

class HeightInchTextField extends StatefulWidget {
  const HeightInchTextField({
    Key key,
    @required TextEditingController b,
    @required this.bmiData,
  })  : _b = b,
        super(key: key);

  // ignore: unused_field
  final TextEditingController _b;
  final BMIContainerData bmiData;

  @override
  _HeightInchTextFieldState createState() => _HeightInchTextFieldState();
}

class _HeightInchTextFieldState extends State<HeightInchTextField> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
         controller: widget._b,
        decoration: InputDecoration(
          hintText:
              DemoLocalization.of(context).getTranslatedValue('HeightInInc'),
          hintStyle: TextStyle(
            fontSize: 14,
            fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(5),
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return DemoLocalization.of(context)
                .getTranslatedValue('HeightInInc');
          }
          return null;
        },
        onChanged: (String value) {
          widget.bmiData.inch = int.parse(value);
        },
      ),
    );
  }
}

class HeighTextfield extends StatefulWidget {
  const HeighTextfield({
    Key key,
    @required TextEditingController a,
    @required this.bmiData,
  })  : _a = a,
        super(key: key);

  final TextEditingController _a;
  final BMIContainerData bmiData;

  @override
  _HeighTextfieldState createState() => _HeighTextfieldState();
}

class _HeighTextfieldState extends State<HeighTextfield> {
  final TextEditingController feetTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller:widget._a,
        decoration: InputDecoration(
          hintText:
              DemoLocalization.of(context).getTranslatedValue('HeightInFeet'),
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
          widget.bmiData.feet = int.parse(value);
          widget._a.text = value;
        },
      ),
    );
  }
}
