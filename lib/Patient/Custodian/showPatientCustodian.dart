import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maseeha_update/Patient/patientScreensData/loginPatientData.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';
import '../../lang_selector.dart';
import 'addMedicineData.dart';

class ShowPatientCustodian extends StatelessWidget {
  static const String id = 'showPatientCustodian_screen';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('medicines').snapshots(),
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            List<Widget> medsCard = [];
             AddMedicineData data; 
            final medicines =  snapshot.data.docs;
            
            final email =
                context.read<LoginPatientData>().getCurrentPatientData();

            for (var medicine in medicines) {
              if (email == medicine['PatientEmail']) {
                 data =
                    AddMedicineData.fromMedicineJson(medicine.data());

          
              }
            

            medsCard.add(
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal : 50.0),
                      child: Card(
                        child: Container(
                          
                          height: size.height * 0.25,
                          child: SingleChildScrollView(
                                                      child: Column(
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    SizedBox(width: 25),
                                    Container(
                                      child: Text(
                                        'Medicine Name',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Jameel Noori Nastaleeq Kasheeda',),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Container(
                                      child: Text(
                                        data.medName ?? 'No data',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 10),

                                Row(
                                  children: [
                                      SizedBox(width: 25),
                                    Container(
                                      child: Text(
                                        'Medicine Quantity',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Jameel Noori Nastaleeq Kasheeda',),
                                      ),
                                    ),
                                      SizedBox(width: 20),
                                    Container(
                                      child: Text(
                                        data.medQuantity.toString() ?? 'No data',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                      SizedBox(width: 25),
                                    Container(
                                      child: Text(
                                        'Medicine Total Quantity',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Jameel Noori Nastaleeq Kasheeda',),
                                      ),
                                    ),
                                      SizedBox(width: 20),
                                    Container(
                                      child: Text(
                                        data.medTotalQuantity.toString() ?? 'No data',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                      SizedBox(width: 25),
                                    Container(
                                      child: Text(
                                        'Medicine Time',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Jameel Noori Nastaleeq Kasheeda',),
                                      ),
                                    ),
                                      SizedBox(width: 20),
                                    Container(
                                      child: Text(
                                        data.time ?? 'No data',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              
                                // ignore: deprecated_member_use
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return ListView(
                  children: medsCard,
                );
              },
            )),
    
    );
  }
}
