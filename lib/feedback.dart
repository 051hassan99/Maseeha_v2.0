import 'package:flutter/material.dart';
import 'package:maseeha_update/classes/review.dart';
import 'package:maseeha_update/localization/demo_localization.dart';
import 'package:provider/provider.dart';
class UserFeedback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final reviewData =
        Provider.of<Review>(context, listen: false);
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [      
                
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFBC7C7C7),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(80),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    child: Icon(
                      Icons.account_circle,
                      size: 20,
                      color: Color(0xFFBB9B9B9),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: DemoLocalization.of(context)
                            .getTranslatedValue('efullname'),
                        hintStyle: TextStyle(fontSize: 14,
                        fontFamily: 'Jameel Noori Nastaleeq Kasheeda'),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return DemoLocalization.of(context)
                              .getTranslatedValue('namerequired');
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        reviewData.name = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFBC7C7C7),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(80),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    child: Icon(
                      Icons.rate_review,
                      size: 20,
                      color: Color(0xFFBB9B9B9),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: DemoLocalization.of(context)
                            .getTranslatedValue('rateMessage'),
                        hintStyle: TextStyle(fontSize: 14,
                        fontFamily: 'Jameel Noori Nastaleeq Kasheeda'),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return DemoLocalization.of(context)
                              .getTranslatedValue('namerequired');
                        }
                        return null;
                      },
                      onChanged: (String value) {

                        reviewData.rating = value;
                       
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(4),
              width: 300,
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFBC7C7C7),
                  width: 2,
                ),
              ),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: DemoLocalization.of(context)
                      .getTranslatedValue('writeReview'),
                  hintStyle: TextStyle(fontSize: 12,
                  fontFamily: 'Jameel Noori Nastaleeq Kasheeda'),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8),
                ),
                onChanged: (value) {

                  reviewData.ratingMessage = value;
                
                },
              ),
            ),
          ],
        ),
      );
  }
}