import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maseeha_update/Doctor/doctor_dashboard.dart';
import 'package:maseeha_update/Doctor/doctor_login.dart';
import 'package:maseeha_update/Patient/patient_dashboard.dart';
import 'package:maseeha_update/Patient/patient_login.dart';
import 'package:maseeha_update/caretaker/caretaker_dashboard.dart';
import 'lang_selector.dart';
import 'localization/demo_localization.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: LayoutBuilder(
            builder: (_, constraints) {
              return Column(
                children: [
                  _getScreenHeader(context),
                  _getContent(context),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _getScreenHeader(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: (size.height * 3) / 10,
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Text(
              DemoLocalization.of(context).getTranslatedValue('title'),
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
    );
  }

  Widget _getContent(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        height: (size.height * 7) / 10,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
        ),
        child: ListView(
          children: [
            Container(
              height: size.height * 0.15,
              child: Center(
                child: Text(
                  DemoLocalization.of(context).getTranslatedValue('category'),
                  style: GoogleFonts.rajdhani(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CategoryButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PatientLogin(),
                      ),
                    );
                  },
                  imagePath: 'assets/images/patient.svg',
                  text: 'p',
                ),
                CategoryButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorLogin(),
                      ),
                    );
                  },
                  imagePath: 'assets/images/doctor.svg',
                  text: 'd',
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width / 3.5),
              child: CategoryButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CaretakerDashboard(),
                    ),
                  );
                },
                imagePath: 'assets/images/nanny.svg',
                text: 'c',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    Key key,
    @required this.imagePath,
    @required this.text,
    @required this.onTap,
    this.width,
    this.height,
  }) : super(key: key);

  final String imagePath;
  final String text;
  final Function onTap;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        height: this.height ?? 140,
        width: this.width ?? 150,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: LayoutBuilder(
          builder: (_, constraints) {
            return Column(
              children: [
                SizedBox(
                  width: constraints.biggest.width * 0.7,
                  height: constraints.biggest.height * 0.7,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                    ),
                    child: SvgPicture.asset(
                      this.imagePath,
                      semanticsLabel: 'Tablet',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    DemoLocalization.of(context).getTranslatedValue(this.text),
                    style: GoogleFonts.rajdhani(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
