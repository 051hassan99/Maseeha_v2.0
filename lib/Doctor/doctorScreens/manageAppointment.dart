import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maseeha_update/Doctor/doctorScreens/apointment_messages.dart';
import 'package:maseeha_update/Patient/Chat/screens/chats/chatFunctionality.dart';
import 'package:maseeha_update/Patient/patientScreensData/newAppointmentdata.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:maseeha_update/token.dart';
import 'package:provider/provider.dart';



class ManageAppointment extends StatefulWidget {

  @override
  _ManageAppointmentState createState() => _ManageAppointmentState();
}

class _ManageAppointmentState extends State<ManageAppointment> {
 final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  NewAppointmentData result;
   String query;

    final myQuery = TextEditingController();

   Future <NewAppointmentData> searchPatient(queryName)async {

     NewAppointmentData message;
    

  
   await  _firestore
        .collection("appointments")
        .where("PatientName", isEqualTo: queryName)
        .get()
        .then((value) {
      value.docs.forEach((result) {
       
       message =NewAppointmentData.fromJson(result.data());

       
      });
    });

 
    
    return message;
  }


  Future <bool> deletePatientData (queryName)async{

    bool deleted = false;
    try{
    await  _firestore
        .collection("appointments")
        .where("PatientName", isEqualTo: queryName).get().
        then((value) {
        value.docs.forEach((doc) {
       
            doc.reference.delete();
            deleted = true;
       
      });
    });
    }

    catch(e){
        print(e.toString());

    }

  return deleted;



  }

  @override
  Widget build(BuildContext context) {

   
     final token = Provider.of<Token>(context, listen: false);
    
    Size size = MediaQuery.of(context).size;
   
   
    return Scaffold(
        body: ProgressHUD(
        
       child: Builder(
          builder: (context) =>
          Column(children: [
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(width: 10),
            IconButton(
              icon: new Icon(Icons.arrow_back,
              size: 35,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: (){
              Navigator.pop(context);
            },
            ),
            SizedBox(width: 80),
            Container(
              width: size.width * 0.28,
              child: Center(
                child: Text(
                  DemoLocalization.of(context).getTranslatedValue('title'),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
      ]),

      SizedBox(height: 20),
      Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width / 9),
            child: Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(4),
              width: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFBC7C7C7),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(60),
              ),
              child: TextFormField(
                controller: myQuery,
                decoration: InputDecoration(
                  hintText:  DemoLocalization.of(context).getTranslatedValue('EnterYourQueryHere'),
                  hintStyle: TextStyle(
                    fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(20),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return DemoLocalization.of(context)
                        .getTranslatedValue('emailrequired');
                  }
                  return value;
                },
                onChanged: (String value) {
                    query = value;

                },
              ),
            ),
      ),

         SizedBox(height: 10),
      Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            // ignore: deprecated_member_use
            FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Text(
                    DemoLocalization.of(context).getTranslatedValue('Search'),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                      fontSize: 18,
                      color: Theme.of(context).primaryColor,
                ),
                ),
                onPressed: () async {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }

                   final progress = ProgressHUD.of(context);
                        progress?.show();

      
                  print("Searching result is "+query);

                 
                    final resultQuery = await searchPatient(query);

                    
                      setState(() {
                      result = resultQuery;
                      myQuery.clear();
                    });

                    progress?.dismiss();
                }
                ),
                
            // ignore: deprecated_member_use
            FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Text(
                   DemoLocalization.of(context).getTranslatedValue('Delete'),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                      color: Theme.of(context).primaryColor),
                ),
                onPressed: () async{

                  final actionPerformed = await deletePatientData(query);


                  if(actionPerformed){

                      Fluttertoast.showToast(
                                                      msg: 'You have succesfully deleted document',
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      backgroundColor:
                                                          Colors.blue,
                                                      textColor: Colors.white);
                  }
                }),
            // ignore: deprecated_member_use
            FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Text(
                  DemoLocalization.of(context)
                          .getTranslatedValue('Cancel'),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                      fontSize: 18,
                      color:Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  
                  

                }),
      ]),

      Column(
            children: [

              SizedBox(height: 40),

              result == null ?

               Text( DemoLocalization.of(context).getTranslatedValue('NoDataRightNow'))
             
                : GestureDetector(
                        child: MessageAppointment(size: size, message: result,),
                        onTap: (){

                          token.targetUserEmail = result.patientEmail;
                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChatFunctionality(result.name)));
                          

                        },
                        )

              
              
  
            ],
      )
    ]),
       ),
        ));
  }
}
