import 'package:flutter/cupertino.dart';

class AddMedicineData extends ChangeNotifier {
  String medName;
  int medQuantity;
  int medTotalQuantity;
  String time;
  String patientEmail;

  AddMedicineData(
      {this.medName,
      this.medQuantity,
      this.medTotalQuantity,
      this.time,
      this.patientEmail});

  factory AddMedicineData.fromMedicineJson(Map<String, dynamic> map) {
    return AddMedicineData(
      medName: map['MedicineName'],
      medQuantity: map['MedicineQuantity'],
      medTotalQuantity: map['MedicineTotalQuantity'],
      time: map['DoseTime'],
      patientEmail: map['PatientEmail'],
    );
  }

  Map<String, dynamic> get toMedicineJson => {
        "MedicineName": this.medName,
        "MedicineQuantity": this.medQuantity,
        "MedicineTotalQuantity": this.medTotalQuantity,
        "DoseTime": this.time,
        "PatientEmail": this.patientEmail,
      };
}
