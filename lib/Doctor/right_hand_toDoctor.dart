import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maseeha_update/Doctor/upeeContainer.dart';
import 'package:maseeha_update/localization/demo_localization.dart';

import '../lang_selector.dart';
import 'bmi_Container.dart';
import 'bmrContainer.dart';
import 'doctor_drawer.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class RightHandToDoctor extends StatelessWidget {
  void calculate(ctx, option) {
    if (option == 1) {
      showModalBottomSheet(
          context: ctx,
          builder: (BuildContext bc) {
            return BMIContainer();
          });
    } else if (option == 2) {
      showModalBottomSheet(
          context: ctx,
          builder: (BuildContext bc) {
            return UPEEContainer();
          });
    } else {
      showModalBottomSheet(
          context: ctx,
          builder: (BuildContext bc) {
            return BMRContainer();
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var _mainColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(
            right: size.width / 30,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: size.width * 0.28,
                child: Center(
                  child: Text(
                    DemoLocalization.of(context).getTranslatedValue('title'),
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                left: size.width / 30,
                right: size.width / 30,
              ),
              child: LangSelector()),
        ],
      ),
      drawer: DoctorDrawer(),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: size.height / 35,
                  bottom: size.width / 30,
                ),
                child: Text(
                  DemoLocalization.of(context)
                      .getTranslatedValue('DoctorAssistant'),
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 70,
            ),
            child: FittedBox(
              fit: BoxFit.contain,
              child: _buildCard(
                icon: Icon(
                  Icons.calculate_outlined,
                  size: 30,
                  color: _mainColor,
                ),
                text: FlatButton(
                  child: Text(
                    DemoLocalization.of(context).getTranslatedValue('BMI'),
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    try {
                      calculate(context, 1);
                    } catch (err) {
                      print(err.toString());
                    }
                  },
                ),
                context: context,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 70,
            ),
            child: FittedBox(
              fit: BoxFit.contain,
              child: _buildCard(
                icon: Icon(
                  Icons.calculate_outlined,
                  size: 30,
                  color: _mainColor,
                ),
                text: FlatButton(
                  child: Text(
                    DemoLocalization.of(context).getTranslatedValue('UPEE'),
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    try {
                      calculate(context, 2);
                    } catch (err) {
                      print(err.toString());
                    }
                  },
                ),
                context: context,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 70,
            ),
            child: FittedBox(
              fit: BoxFit.contain,
              child: _buildCard(
                icon: Icon(
                  Icons.calculate_outlined,
                  size: 30,
                  color: _mainColor,
                ),
                text: FlatButton(
                  child: Text(
                    DemoLocalization.of(context).getTranslatedValue('BMR'),
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    try {
                      calculate(context, 3);
                    } catch (err) {
                      print(err.toString());
                    }
                  },
                ),
                context: context,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Container _buildCard(
    {final Icon icon, final FlatButton text, BuildContext context}) {
  Size size = MediaQuery.of(context).size;
  return Container(
    height: size.height / 4.8,
    width: size.width / 1.6,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    padding: EdgeInsets.all(5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: size.height / 11,
          width: size.width / 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 4,
              color: Theme.of(context).primaryColor,
            ),
          ),
          child: icon,
        ),
        text,
      ],
    ),
  );
}
