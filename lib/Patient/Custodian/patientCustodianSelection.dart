import 'package:flutter/material.dart';
import 'package:maseeha_update/Patient/Custodian/localNotificationImplement.dart';
import 'package:maseeha_update/Patient/Custodian/showPatientCustodian.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';
import '../../category.dart';
import '../../lang_selector.dart';
import 'addMedicine.dart';

class PatientCustodianSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  //   final localNotificationImplement =  Provider.of<LocalNotificationImplement>(context, listen: false);
    Provider.of<LocalNotificationImplement>(context).context = context;
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
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
                        fontFamily: 'Jameel Noori Nastaleeq Kasheeda'
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
        body: LayoutBuilder(
          builder: (_, constraints) {
            return ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(height: 20),
               
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: CategoryButton(
                    imagePath: 'assets/images/med.svg',
                    text: 'addMedicine',
                    height: constraints.biggest.height * 0.42,
                    width: 10,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddMedicine(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: CategoryButton(
                    imagePath: 'assets/images/aspirin.svg',
                    text: 'custodianDashboard',
                    height: constraints.biggest.height * 0.42,
                    width: 10,
                    onTap: () {
                      Navigator.popAndPushNamed(
                          context, ShowPatientCustodian.id);
                    },
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
