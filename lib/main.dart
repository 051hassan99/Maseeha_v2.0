import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:maseeha_update/Caretaker/caretakerAppointmentReplyData.dart';
import 'package:maseeha_update/Doctor/appointmentReply/appointmentReply.dart';
import 'package:maseeha_update/Map/userTypeforMap.dart';
import 'package:maseeha_update/Notification/notification.dart';
import 'package:maseeha_update/Patient/Custodian/localNotificationImplement.dart';
import 'package:maseeha_update/Patient/caretakerAppointment/caretakerNewAppointmentData.dart';
import 'package:maseeha_update/Patient/patientScreens/doctorList.dart';
import 'package:maseeha_update/category.dart';
import 'package:maseeha_update/loadingScreen.dart';
import 'package:maseeha_update/token.dart';
import 'package:provider/provider.dart';
import 'Doctor/doctorScreens/apointment_messages.dart';
import 'Doctor/doctorScreens/doctor_dashboard.dart';
import 'Doctor/doctorScreensData/bmiContainer_Data.dart';
import 'Doctor/doctorScreensData/bmrContainerData.dart';
import 'Doctor/doctorScreensData/doctorRegisterData.dart';
import 'Doctor/doctorScreensData/loginDoctorData.dart';
import 'Doctor/doctorScreensData/upeeContainerData.dart';
import 'Map/DataHandler/AppData.dart';
import 'Patient/Custodian/addMedicineData.dart';
import 'Patient/Custodian/showPatientCustodian.dart';
import 'Patient/patientScreens/patient_dashboard.dart';
import 'Patient/patientScreensData/AppUserData.dart';
import 'Patient/patientScreensData/loginPatientData.dart';
import 'Patient/patientScreensData/newAppointmentdata.dart';
import 'Caretaker/caretakerRegister.dart';
import 'Caretaker/loginCaretakerData.dart';
import 'classes/doctor.dart';
import 'localization/demo_localization.dart';
import 'splashScreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
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


  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    
    // getToken();
  }


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
          create: (_) => AppointmentReply(),
        ),
        ChangeNotifierProvider(
          create: (context) => Doctor(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationSend(),
        ),
        ChangeNotifierProvider(
          create: (context) => Token(),
        ),
         ChangeNotifierProvider(
          create: (context) => LocalNotificationImplement(),
        ),
         ChangeNotifierProvider(
          create: (context) => UserType(),
        ),
         ChangeNotifierProvider(
          create: (_) => CaretakerAppointmentReplyData(),
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
     
        initialRoute: LoadingScreen.id,
        routes: {
          LoadingScreen.id: (_) => LoadingScreen(),
          SplashScreen.id: (_) => SplashScreen(),
          Category.id: (_) => Category(),
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

