import 'package:flutter/cupertino.dart';

class AddMedicineData extends ChangeNotifier {
  String medName;
  String medDescription;
  String date;
  String time;
  String patientEmail;
  bool loading = false;

  AddMedicineData(
      {this.medName,
      this.medDescription,
      this.date,
      this.time,
      this.patientEmail});

void toggleLoading(){

    loading = !loading;
     notifyListeners();
}


  factory AddMedicineData.fromMedicineJson(Map<String, dynamic> map) {
    return AddMedicineData(
      medName: map['MedicineName'],
      medDescription: map['MedicineDescription'],
      date: map['DoseDate'],
      time: map['DoseTime'],
      patientEmail: map['PatientEmail'],
    );
  }

  Map<String, dynamic> get toMedicineJson => {
        "MedicineName": this.medName,
        "MedicineDescription": this.medDescription,
        "DoseDate": this.date,
        "DoseTime": this.time,
        "PatientEmail": this.patientEmail,
      };
}
