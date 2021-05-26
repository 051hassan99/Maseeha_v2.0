import 'package:flutter/material.dart';
import 'package:maseeha_update/Doctor/doctorScreensData/upeeContainerData.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';

class UPEEContainer extends StatelessWidget {
  static final _formkey = GlobalKey<FormState>();

  final _a = TextEditingController();
  final _c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final upeeData = Provider.of<UPEEContainerData>(context, listen: false);

    Size size = MediaQuery.of(context).size;

    return Form(
      key: _formkey,
      child: SingleChildScrollView(
        child: Column(
          children: [
           
        SizedBox(height: size.height * 0.06),
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
              child: Container(
                padding: EdgeInsets.only(
                  left: 20,
                ),
                child: SpotUrineProtientTextField(a: _a, upeeData: upeeData),
              ),
            ),
                       SizedBox(height: size.height * 0.06),
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
              child: Container(
                padding: EdgeInsets.only(
                  left: 20,
                ),
                child: SpotUrineCreateTextField(c: _c, upeeData: upeeData),
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
                      'Result',
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

                        upeeData.resultofCalculation(upeeData.sup, upeeData.suc);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: Consumer<UPEEContainerData>(
                      builder: (context, upeeData, _) {
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
                          upeeData.myFinalResult,
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
                      'Clear',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
                      ),
                    ),
                    onPressed: () {
                      _a.clear(); 
                      _c.clear();
                      upeeData.clearValues();
                    
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

class SpotUrineCreateTextField extends StatefulWidget {
  const SpotUrineCreateTextField({
    Key key,
    @required TextEditingController c,
    @required this.upeeData,
  }) : _c = c, super(key: key);

  final TextEditingController _c;
  final UPEEContainerData upeeData;

  @override
  _SpotUrineCreateTextFieldState createState() => _SpotUrineCreateTextFieldState();
}

class _SpotUrineCreateTextFieldState extends State<SpotUrineCreateTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._c,
      decoration: InputDecoration(
        hintText:
            DemoLocalization.of(context).getTranslatedValue('SUC'),
        border: InputBorder.none,
          hintStyle: TextStyle(
            fontSize: 14,
            fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
          ),
        contentPadding: EdgeInsets.all(10),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return DemoLocalization.of(context)
              .getTranslatedValue('SUC');
        }
        return null;
      },
      onChanged: (String value) {
        widget.upeeData.suc = double.parse(value);
      },
    );
  }
}

class SpotUrineProtientTextField extends StatefulWidget {
  const SpotUrineProtientTextField({
    Key key,
    @required TextEditingController a,
    @required this.upeeData,
  }) : _a = a, super(key: key);

  final TextEditingController _a;
  final UPEEContainerData upeeData;

  @override
  _SpotUrineProtientTextFieldState createState() => _SpotUrineProtientTextFieldState();
}

class _SpotUrineProtientTextFieldState extends State<SpotUrineProtientTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._a,
      decoration: InputDecoration(
        hintText:
            DemoLocalization.of(context).getTranslatedValue('SUP'),
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
              .getTranslatedValue('SUP');
        }
        return null;
      },
      onChanged: (String value) {
        widget.upeeData.sup = double.parse(value);
      },
    );
  }
}
