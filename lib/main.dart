import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:maseeha_update/Custodian/showPatientCustodian.dart';
import 'package:maseeha_update/DataHandler/AppData.dart';
import 'package:maseeha_update/Doctor/appointmentReply/appointmentReply.dart';
import 'package:maseeha_update/Doctor/doctor_dashboard.dart';
import 'package:maseeha_update/Models/login_data.dart';
import 'package:maseeha_update/Patient/caretakerAppointment/caretakerNewAppointmentData.dart';
import 'package:maseeha_update/Patient/doctorList.dart';
import 'package:maseeha_update/Patient/patient_dashboard.dart';
import 'package:maseeha_update/Patient/patient_login.dart';
import 'package:maseeha_update/category.dart';
import 'package:maseeha_update/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'Custodian/addMedicineData.dart';
import 'Doctor/apointment_messages.dart';
import 'Doctor/bmiContainer_Data.dart';
import 'Doctor/bmrContainerData.dart';
import 'Doctor/doctorRegisterData.dart';
import 'Doctor/loginDoctorData.dart';
import 'Doctor/upeeContainerData.dart';
import 'Patient/AppUserData.dart';
import 'Patient/loginPatientData.dart';
import 'Patient/newAppointmentdata.dart';
import 'caretaker/caretakerRegister.dart';
import 'caretaker/loginCaretakerData.dart';
import 'localization/demo_localization.dart';
import 'splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var bgcolor = Colors.blue;
  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppUserData(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginPatientData(),
        ),
        ChangeNotifierProvider(create: (_) => NewAppointmentData()),
        ChangeNotifierProvider(
          create: (context) => LoginPatientData(),
        ),
        ChangeNotifierProvider(
          create: (context) => DoctorRegisterData(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginDoctorData(),
        ),
        ChangeNotifierProvider(
          create: (context) => CaretakerRegisterData(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginCaretakerData(),
        ),
        ChangeNotifierProvider(
          create: (context) => NewAppointmentData(),
        ),
        ChangeNotifierProvider(
          create: (context) => BMIContainerData(),
        ),
        ChangeNotifierProvider(
          create: (context) => UPEEContainerData(),
        ),
        ChangeNotifierProvider(
          create: (context) => BMRContainerData(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddMedicineData(),
        ),
        ChangeNotifierProvider(
          create: (context) => CaretakerNewAppointmentData(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppData(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginData(),
        ),
        ChangeNotifierProvider(
          create: (_) => AppointmentReply(),
        ),
      ],
      child: MaterialApp(
        locale: _locale,
        supportedLocales: [Locale('en', 'US'), Locale('ur', 'PK')],
        localizationsDelegates: [
          DemoLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale.languageCode &&
                locale.countryCode == deviceLocale.countryCode) {
              return deviceLocale;
            }
          }
          return supportedLocales.first;
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // hassabahmed
          primaryColor: bgcolor,
        ),
        /* home: Scaffold(
          body: Container(
            child: SplashScreen(),
          ),
        ), */
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (_) => SplashScreen(),
          Category.id: (_) => Category(),
          LoginScreen.id: (_) => LoginScreen(),
          PatientDashboard.id: (_) => PatientDashboard(),
          DoctorDashboard.id: (_) => DoctorDashboard(),
          DoctorList.id: (_) => DoctorList(),
          Appointments.id: (_) => Appointments(),
          ShowPatientCustodian.id: (_) => ShowPatientCustodian()
        },
      ),
    );
  }
}
