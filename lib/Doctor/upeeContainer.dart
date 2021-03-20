import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maseeha_update/Doctor/upeeContainerData.dart';
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
      child: ListView(
        children: [
          Container(
            height: size.height / 10,
            margin: EdgeInsets.symmetric(
              vertical: size.height / 35,
            ),
            child: Center(
              child: Text(
                DemoLocalization.of(context).getTranslatedValue('UPEE'),
                style: GoogleFonts.rajdhani(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          SizedBox(height: size.height / 50),
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
                  controller: _a,
                  decoration: InputDecoration(
                    hintText:
                        DemoLocalization.of(context).getTranslatedValue('SUP'),
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
                    upeeData.sup = double.parse(value);
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: size.height / 50),
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
                        DemoLocalization.of(context).getTranslatedValue('SUC'),
                    border: InputBorder.none,
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
                    upeeData.suc = double.parse(value);
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
                        upeeData.resultofCalculation(
                            upeeData.sup, upeeData.suc);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: Consumer<UPEEContainerData>(
                      builder: (context, upeeData, _) {
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
                          upeeData.myFinalResult,
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
                      _c.clear();
                      upeeData.clearValues();
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
