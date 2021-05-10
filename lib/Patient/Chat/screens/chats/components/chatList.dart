import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maseeha_update/classes/doctor.dart';
import '../../../constants.dart';
import 'package:provider/provider.dart';

import '../chatFunctionality.dart';


class ChatList extends StatelessWidget {
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.fromLTRB(
              kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
          color:Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
             
              // ignore: deprecated_member_use
              FlatButton(onPressed: () {}, 
              child: Text("Recent Message",
              style: TextStyle(color: Colors.white ),),
              autofocus: true,
              color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: kDefaultPadding),
              // ignore: deprecated_member_use
              FlatButton(
                onPressed: () {},
                child:Text("Active",
                style: TextStyle(color: Colors.white ),),
                color: Theme.of(context).primaryColor,
                autofocus: false,
                
              ),
            ],
          ),
        ),
        Expanded(
         child:Container(
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width / 8,
            ),
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('doctors').snapshots(),
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final doctors = snapshot.data.docs;
                print(doctors.length);

                List<Widget> doctorCards = [];
                for (var doctor in doctors) {
                  Doctor doc = Doctor.fromJson(doctor.data());
                  print(doc.fullName);
                  doctorCards.add(Container(
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
                              height: 180,
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(size.width / 30),
                                    child: Text(
                                      doc.fullName ?? 'No data',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    doc.hospital ?? 'No data',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    doc.docEmail ?? 'No data',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    doc.specialization ?? 'No data',
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

                                      context.read<Doctor>().chatDoctorName = doc.fullName;
                                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>ChatFunctionality(),
                          ),
                        );
                                     
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
                  children: doctorCards,
                );
              },
            )),
      ),
        ),
      ],
    );
  }
}
