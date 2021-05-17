import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maseeha_update/Doctor/doctorScreens/doctor_login.dart';
import 'package:maseeha_update/classes/doctor.dart';
import 'package:provider/provider.dart';


class DoctorDrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

   
       final doctorData =
        Provider.of<Doctor>(context, listen: false);

    return Drawer(
        child: ListView(
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
        
        

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: 
            
            
            Center(
              child: Column(
                children: <Widget>[
                 
                  Container(
                    width: 100,
                    height: 120,
                    margin: EdgeInsets.only(
                      top: 30,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage( 'https://images.unsplash.com/photo-1486312338219-ce68d2c6f44d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=752&q=80'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                  Center(
                    child: Text(" Account Information",
                      style: TextStyle(
                    
                      fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                      color:Colors.white,
                      fontSize: 16,
                             ),
                             )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:[ 

                              SizedBox(width: 10),

                              Text("User Name ",
                                style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                      color: Colors.white,
                      fontSize: 16,
                    ),),

                    SizedBox(width: 20),
                              
                              Text(
                         doctorData.userList[D.doctorName.index]!=
                                null
                            ? 
                                 doctorData.userList[D.doctorName.index]
                            : 'Mark ZukerBerg',
                              style: TextStyle(
                    
                      fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                      color:Colors.white,
                      fontSize: 16,
                             )
                      ),
                    ]
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:[ 
                              SizedBox(width: 10),

                              Text("User Email",
                                style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                      color:Colors.white,
                      fontSize: 16,
                    ),),

                     SizedBox(width: 20),
                              
                              Text(
                      doctorData.userList[D.email.index] !=
                                null
                            ? doctorData.userList[D.email.index] 
                            : 'abc@gmail.com',
                             style: TextStyle(
                    
                      fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                      color:Colors.white,
                      fontSize: 16,
                             )
                      ),
                    ]
                    ),
                  ),

                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[ 

                      SizedBox(width: 10),

                      Text("Doctor PMDC No ",
                        style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                        color: Colors.white,
                        fontSize: 16,
                      ),),

                      SizedBox(width: 20),
                      
                      Text(
                          doctorData.userList[D.pmdc.index] !=
                        null
                    ? 
                         doctorData.userList[D.pmdc.index]
                    : 'Mark ZukerBerg',
                      style: TextStyle(
                      
                        fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                        color:Colors.white,
                        fontSize: 16,
                     )
                        ),
                      ]
                      ),
                  ),

                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:[ 

                              SizedBox(width: 10),

                              Text("Doctor Specialization ",
                                style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                      color: Colors.white,
                      fontSize: 16,
                    ),),

                    SizedBox(width: 20),
                              
                              Text(
                         doctorData.userList[D.specialization.index]!=
                                null
                            ? 
                                 doctorData.userList[D.specialization.index]
                            : 'Mark ZukerBerg',
                              style: TextStyle(
                    
                      fontFamily: 'Jameel Noori Nastaleeq Kasheeda',
                      color:Colors.white,
                      fontSize: 16,
                             )
                      ),
                    ]
                    ),
                  ),
                ],
              ),
            ),
          ),
            
             ListTile(
                title: Text('Profile'),
                leading: Icon(Icons.person),
                onLongPress: (){},
                ),



          
             

              Divider(),


              ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings),
                onLongPress: (){},
                ),

              Divider(),


              Divider(),
              ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.close),
                onTap: ()async{
                 
                  final auth = FirebaseAuth.instance;
                  auth.signOut();
                  
                  while (Navigator.canPop(context)){
                    Navigator.pop(context);
                  }
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => DoctorLogin()),
                  );}
                ),
          ]
        ),

    );
    
  }
    
}