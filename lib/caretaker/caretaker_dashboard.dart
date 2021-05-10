import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maseeha_update/Map/mapbuilding.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import '../lang_selector.dart';
import 'caretaker_drawer.dart';

class CaretakerDashboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
        drawer: CaretakerDrawer(),
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
                        .getTranslatedValue('caretakerdashboard'),
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
             GestureDetector(
                      onTap: () {


                        
                      },
                      child: _buildCard(
                        svgPicture: SvgPicture.asset(
                            'assets/images/viewpatients.svg',
                            semanticsLabel: 'Tablet'),
                        text: Text(
                          DemoLocalization.of(context)
                              .getTranslatedValue('ViewPatients'),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        context: context,
                      ),
                    ),
                    SizedBox(height: 20),
                      GestureDetector(
                      onTap: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapBuilding(),
                          ),
                        );
                        
                      },
                      child: _buildCard(
                        svgPicture: SvgPicture.asset(
                            'assets/images/map.svg',
                            semanticsLabel: 'Tablet'),
                        text: Text(
                          DemoLocalization.of(context)
                              .getTranslatedValue('FindLocation'),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        context: context,
                      ),
                    ),
          

          ],
        ));
  }
}

Padding _buildCard(
    {final SvgPicture svgPicture, Text text, BuildContext context}) {
  Size size = MediaQuery.of(context).size;
  return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 40
      ),
      child: Container(
      height: size.height / 3.2,
      width: size.width / 2.5,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 6.0,
            offset: Offset(0.7, 0.7),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: size.height / 6,
            width: size.width / 4,
            child: svgPicture,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: text,
          ),
        ],
      ),
    ),
  );
}