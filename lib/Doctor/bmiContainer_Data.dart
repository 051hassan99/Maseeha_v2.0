import 'package:flutter/cupertino.dart';

class BMIContainerData extends ChangeNotifier {

    int feet;
    int inch;
    double mass;
    double meter;
    double result; 
    String myFinalResult = '0.00';


    void clearValues(){

       feet = 0;
       inch = 0;
       mass =0;
       meter = 0;
       result = 0; 
       myFinalResult = '0.00';
       notifyListeners();
    }

    int feetToInches(){
     inch =  12 * feet + inch;
     return inch; 
    }
    
    double inchesToMeter(){

        meter = inch * 0.0254;
        return meter;

    }
  void finalResult (meter,mass){
            inch = feetToInches();
            meter =inchesToMeter();
            result = mass / (meter * meter);
            myFinalResult = result.toStringAsFixed(2);
            notifyListeners();
  }

}