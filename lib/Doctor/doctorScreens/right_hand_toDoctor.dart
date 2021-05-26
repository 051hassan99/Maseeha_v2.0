import 'package:flutter/material.dart';
import 'package:maseeha_update/Doctor/doctorScreens/doctorProfileScreen.dart';
import 'package:maseeha_update/Doctor/doctorScreens/upeeContainer.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import '../../category.dart';
import '../../lang_selector.dart';
import 'bmi_Container.dart';
import 'bmrContainer.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class RightHandToDoctor extends StatelessWidget {
  Widget containerReturn(type) {
    Widget myWidget;
    if (type == 1) {
      myWidget = BMIContainer();
    } else if (type == 2) {
      myWidget = UPEEContainer();
    } else {
      myWidget = BMRContainer();
    }

    return myWidget;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void showDialogBox(type, text) {
      showDialog(
          context: context,
          // ignore: missing_return
          builder: (context) {
            return AlertDialog(
              title: Container(
                height: 50,
                width: 100,
                child: Center(
                  child: Text(
                    DemoLocalization.of(context).getTranslatedValue(text),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              content: containerReturn(type),
            );
          });
    }

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
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Jameel Noori Nastaleeq Kasheeda'),
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
      drawer: DoctorDrawerMenu(),
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
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      fontSize: 25,
                      fontFamily: 'Jameel Noori Nastaleeq Kasheeda'),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.09),
            child: CategoryButton(
              onTap: () {
                try {
                  showDialogBox(1, "BMI");
                } catch (err) {
                  print(err.toString());
                }
              },
              imagePath: 'assets/images/bmi .svg',
              text: 'BMI',
            ),
          ),
         SizedBox(height: size.height * 0.02),
          Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.09),
            child: CategoryButton(
              onTap: () {
                try {
                  showDialogBox(2, "UPEE");
                } catch (err) {
                  print(err.toString());
                }
              },
              imagePath: 'assets/images/upee.svg',
              text: 'UPEE',
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.09),
            child: CategoryButton(
              onTap: () {
                try {
                  showDialogBox(3, "BMR");
                } catch (err) {
                  print(err.toString());
                }
              },
              imagePath: 'assets/images/bmr.svg',
              text: 'BMR',
            ),
          ),
        ],
      ),
    );
  }
}
