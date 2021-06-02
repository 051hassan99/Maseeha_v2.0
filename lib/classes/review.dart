import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
class Review extends ChangeNotifier{

  String name;
  String rating;
  String ratingMessage;

  Review({this.name, this.rating, this.ratingMessage});

   factory Review.fromJson(Map<String, dynamic> map) {
    return Review(
        name: map['DoctorName'],
        rating: map['Rating'],
        ratingMessage: map['RatingMessage']);
        
  }

  Map<String, dynamic> get toJson => {
        "DoctorName": this.name,
        "Rating":this.rating,
        "RatingMessage":this.ratingMessage,
        "createdAt": FieldValue.serverTimestamp()
      };


}