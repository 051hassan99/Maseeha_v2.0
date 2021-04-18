import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maseeha_update/category.dart';
import 'package:maseeha_update/lang_selector.dart';
import 'localization/demo_localization.dart';

class SplashScreen extends StatelessWidget {
  static const String id = 'splash_screen';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return new Future(() => false);
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: size.height * 0.33,
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                right: 10,
                              ),
                              child: LangSelector(),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 10,
                          ),
                          child: Column(
                            children: [
                              Text(
                                DemoLocalization.of(context)
                                    .getTranslatedValue('title'),
                                style: GoogleFonts.rajdhani(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 60,
                                    color: Colors.white),
                              ),
                              Text(
                                DemoLocalization.of(context).getTranslatedValue(
                                  'description',
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: size.height * 0.33,
                    width: double.infinity,
                    child: new Image.asset('assets/images/doc.jpg'),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: size.height / 14),
                    padding: EdgeInsets.all(8),
                    width: size.width / 1.5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: FlatButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Text(
                          DemoLocalization.of(context)
                              .getTranslatedValue('btn'),
                          style: GoogleFonts.rajdhani(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        onPressed: () {
                          /* Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Category(),
                            ),
                          ); */
                          Navigator.pushReplacementNamed(context, Category.id);
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
