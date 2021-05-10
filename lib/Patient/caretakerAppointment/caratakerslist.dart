import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maseeha_update/Patient/caretakerAppointment/caretakerNewAppointment.dart';
import 'package:maseeha_update/Patient/caretakerAppointment/caretakerNewAppointmentData.dart';
import 'package:maseeha_update/classes/caretaker.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';

import '../../lang_selector.dart';

//import 'package:path/path.dart';

class CaretakerList extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    void takeCaretakerAppointment(ctx) {
      showModalBottomSheet(
          context: ctx,
          builder: (context) {
            return CaretakerNewAppointment();
          });
    }

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
      body: Container(
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width / 8,
            ),
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('caretakers').snapshots(),
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final caretakers = snapshot.data.docs;
                print(caretakers.length);

                List<Widget> caretakerCards = [];
                for (var caretaker in caretakers) {
                  Caretaker ckts = Caretaker.fromJson(caretaker.data());
                  print(ckts.name);
                  caretakerCards.add(Container(
                    padding: EdgeInsets.only(
                      top: 10,
                    ),
                    child: Card(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Row(
                          children: [
                            Container(
                              height: size.height / 10,
                              width: 120,
                              margin: EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                /* image: DecorationImage(
                                      image: NetworkImage(
                                          'https://www.google.com/url?sa=i&url=https://flutterappworld.com/a-high-performance-flutter-widget-to-render-bottts-svg-avatars/&psig=AOvVaw0pbd2aLdtAYDPZSY8ZCbFK&ust=1605966714142000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCODx_sSike0CFQAAAAAdAAAAABAJ'),
                                    ), */
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                              padding: EdgeInsets.all(5),
                            ),
                            Container(
                              height: 150,
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(size.width / 30),
                                    child: Text(
                                      ckts.name ?? 'No data',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    ckts.pnc ?? 'No data',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    ckts.currentStatus ?? 'No data',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  // ignore: deprecated_member_use
                                  FlatButton(
                                    child: Text(
                                      'Click Here ',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    onPressed: () {
                                      try {
                                        context
                                            .read<CaretakerNewAppointmentData>()
                                            .caretakerName = ckts.name;
                                        takeCaretakerAppointment(context);
                                      } catch (err) {
                                        print(err.toString());
                                      }
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
                }
                return ListView(
                  children: caretakerCards,
                );
              },
            )),
      ),
    );
  }
}
