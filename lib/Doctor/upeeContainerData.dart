import 'package:flutter/cupertino.dart';

class UPEEContainerData extends ChangeNotifier{

  double sup;
  double suc;
  double result;
  String myFinalResult = '0.00';

   void clearValues(){

       sup =0;
       suc =0;   
       myFinalResult = '0.00';
       notifyListeners();
    }

    void resultofCalculation(sup, suc){

          result =   sup/suc;
          myFinalResult = result.toStringAsFixed(2);
          notifyListeners();

    }
}