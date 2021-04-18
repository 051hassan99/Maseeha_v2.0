import 'package:flutter/material.dart';
import 'package:maseeha_update/Assistants/requestAssistant.dart';
import 'package:maseeha_update/DataHandler/AppData.dart';
import 'package:maseeha_update/Models/address.dart';
import 'package:maseeha_update/Models/placePrediction.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController homelocation = TextEditingController();

  final TextEditingController doctorlocation = TextEditingController();

  List<PlacePrediction> placepredictionlist = [];

  @override
  Widget build(BuildContext context) {
    String placeAddress = Provider.of<AppData>(context).userlocation.placeName;

    homelocation.text = placeAddress;
    return SafeArea(
      child: Scaffold(
        body: ListView(children: [
          Container(
            height: 215.0,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 6.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7),
                )
              ],
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 25.0, top: 20, right: 25, bottom: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      Center(
                        child: Text(
                          "Set Doctor Destination",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      Icon(
                        Icons.home,
                        size: 16,
                        color: Colors.white,
                      ),
                      SizedBox(width: 18.0),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(6.0),
                            child: TextField(
                              controller: homelocation,
                              decoration: InputDecoration(
                                hintText: "Your Location",
                                fillColor: Colors.white,
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                  left: 11.0,
                                  right: 8.0,
                                  bottom: 8.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Icon(
                        Icons.home_filled,
                        size: 16,
                        color: Colors.white,
                      ),
                      SizedBox(width: 18.0),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(6.0),
                            child: TextField(
                              onChanged: (val) {
                                findPlace(val);
                              },
                              controller: doctorlocation,
                              decoration: InputDecoration(
                                hintText: "Your Doctor Location",
                                fillColor: Colors.white,
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                  left: 11.0,
                                  right: 8.0,
                                  bottom: 8.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          (placepredictionlist.length > 0)
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.all(0.0),
                    itemBuilder: (context, index) {
                      return PredictionTile(
                        pp: placepredictionlist[index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemCount: placepredictionlist.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                  ),
                )
              : Container(),
        ]),
      ),
    );
  }

  void findPlace(String placeName) async {
    if (placeName.length > 1) {
      String autoCompleteUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=AIzaSyD-yOv-CmxUNv9PQaZaDTAvEiyKVlMY5cE&sessiontoken=1234567890&components=country:pk";

      Uri myUri = Uri.parse(autoCompleteUrl);
      var res = await RequestAssistant.getRequest(myUri);
      if (res == "Failed") {
        return;
      }

      if (res["status"] == "OK") {
        var predictions = res["predictions"];

        var placeslist = (predictions as List)
            .map((e) => PlacePrediction.fromJson(e))
            .toList();

        setState(() {
          placepredictionlist = placeslist;
        });
      }
    }
  }
}

class PredictionTile extends StatelessWidget {
  final PlacePrediction pp;
  PredictionTile({Key key, this.pp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0.0),
      onPressed: () {
        getPlaceDetails(pp.placeId, context);
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(width: 14.0),
            Row(
              children: [
                Icon(Icons.add_location),
                SizedBox(width: 14.0),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(pp.mainText,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16.0)),
                        SizedBox(height: 3.0),
                        Text(
                          pp.secondaryText,
                          style: TextStyle(fontSize: 12.0, color: Colors.grey),
                        ),
                      ]),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void getPlaceDetails(String placeId, context) async {
    String placeDetailUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=AIzaSyD-yOv-CmxUNv9PQaZaDTAvEiyKVlMY5cE";

    Uri myUri = Uri.parse(placeDetailUrl);
    var res = await RequestAssistant.getRequest(myUri);

    if (res == "Failed") {
      return;
    }

    if (res["status"] == "OK") {
      Address address = new Address();
      address.placeName = res["result"]["name"];
      address.placeId = placeId;
      address.latitude = res["result"]["geometry"]["location"]["lat"];
      address.longitude = res["result"]["geometry"]["location"]["lng"];

      Provider.of<AppData>(context, listen: false)
          .updateSearchedlocation(address);
      print("This is searched location:: ");
      print(address.placeName);

      Navigator.pop(context, "obtaindirection");
    }
  }
}
