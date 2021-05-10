import 'package:flutter/cupertino.dart';

class BMRContainerData extends ChangeNotifier {

  String gender;
   int feet;
    int inch;
    double mass;
    double centimeter;
    double bmr;
    int age; 
    String myFinalResult = '0.00';


    void clearValues(){

       feet = 0;
       inch = 0;
       mass =0;
       age =0;
       centimeter = 0;
       bmr = 0; 
       myFinalResult = '0.00';
       genderChanged("abc");
       notifyListeners();
    }

  void genderChanged(String value) {
    gender = value;
    notifyListeners();
  }

  int feetToInches(){
     inch =  12 * feet + inch;
     return inch; 
    }

  double inchestoCM(){
     centimeter =  inch * 2.54;
     return centimeter; 
    }
  

  void calculateResult(){

    inch = feetToInches();
    centimeter =inchestoCM();

    if(gender=="Male"){
      bmr = 66 + (13.7 * mass) + (5 * centimeter) - (6.8 * age); 
      print("YTWHello");
    }

    else
    {
      bmr = (10 * mass) + (6.25 * centimeter) - (5 * age) - 161;
      print("Hello");
    }

    myFinalResult = bmr.toStringAsFixed(2);
            notifyListeners();

  }

}