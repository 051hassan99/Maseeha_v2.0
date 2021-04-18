import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maseeha_update/Assistants/assistantMethods.dart';
import 'package:maseeha_update/DataHandler/AppData.dart';
import 'package:maseeha_update/Patient/searchScreen.dart';
import 'package:provider/provider.dart';

class MapBuilding extends StatefulWidget {
  @override
  _MapBuildingState createState() => _MapBuildingState();
}

class _MapBuildingState extends State<MapBuilding> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  Position currentPosition;
  var geolocator = Geolocator();

  double bottomPaddingOfMap = 0;

  Set<Marker> markerSet = {};
  Set<Circle> circleSet = {};

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latLatPosition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    await AssistantMethods.searchCoordinateAddress(position, context);
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled: true,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              polylines: polylineSet,
              markers: markerSet,
              circles: circleSet,
              onMapCreated: (GoogleMapController controller) {
                _controllerGoogleMap.complete(controller);
                newGoogleMapController = controller;

                setState(() {
                  bottomPaddingOfMap = 300.0;
                });

                locatePosition();
              },
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: GestureDetector(
                onTap: () async {
                  var res = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()));

                  if (res == "obtaindirection") {
                    await getPlaceDirection();
                  }
                },
                child: Container(
                  height: (size.height * 4) / 10,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.0),
                      topRight: Radius.circular(18.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 6.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 18,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 6.0),
                        Text(
                          'Hi There, ',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Your Doctor Location, ',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 6.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7),
                              ),
                            ],
                          ),
                          child: Row(children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 40,
                              ),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Text('Search Your Doctor'),
                          ]),
                        ),
                        SizedBox(height: 24.0),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 20,
                              ),
                              child: Icon(
                                Icons.home,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Container(
                                    height: 60,
                                    width: 250,
                                    padding: EdgeInsets.only(top: 7.0),
                                    child: Text(
                                      Provider.of<AppData>(context)
                                                  .userlocation !=
                                              null
                                          ? Provider.of<AppData>(context)
                                              .userlocation
                                              .placeName
                                          : "Add Home",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getPlaceDirection() async {
    var intialPos = Provider.of<AppData>(context, listen: false).userlocation;
    var finalPos =
        Provider.of<AppData>(context, listen: false).searchedlocation;

    var userIntialLocation = LatLng(intialPos.latitude, intialPos.longitude);
    var finalDestinationLocation =
        LatLng(finalPos.latitude, finalPos.longitude);

    var details = await AssistantMethods.obtainPlacePredictionDetails(
        userIntialLocation, finalDestinationLocation);

    PolylinePoints polylinePoints = new PolylinePoints();
    List<PointLatLng> decodePolyLineResult =
        polylinePoints.decodePolyline(details.encodePoints);

    pLineCoordinates.clear();

    if (decodePolyLineResult.isNotEmpty) {
      decodePolyLineResult.forEach((PointLatLng pointLatLng) {
        pLineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    polylineSet.clear();

    setState(() {
      Polyline polyLine = Polyline(
        color: Colors.pink,
        polylineId: PolylineId(
          "PolyLineID",
        ),
        jointType: JointType.round,
        points: pLineCoordinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );

      polylineSet.add(polyLine);
    });

    LatLngBounds latLngBounds;

    if (userIntialLocation.latitude > finalDestinationLocation.latitude &&
        userIntialLocation.longitude > finalDestinationLocation.longitude) {
      latLngBounds = LatLngBounds(
          southwest: finalDestinationLocation, northeast: userIntialLocation);
    } else if (userIntialLocation.longitude >
        finalDestinationLocation.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(
              userIntialLocation.latitude, finalDestinationLocation.longitude),
          northeast: LatLng(
              finalDestinationLocation.latitude, userIntialLocation.longitude));
    } else if (userIntialLocation.latitude >
        finalDestinationLocation.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(
              finalDestinationLocation.latitude, userIntialLocation.longitude),
          northeast: LatLng(
              userIntialLocation.latitude, finalDestinationLocation.longitude));
    } else {
      latLngBounds = LatLngBounds(
          southwest: userIntialLocation, northeast: finalDestinationLocation);
    }

    newGoogleMapController
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker userIntialLocationMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow:
            InfoWindow(title: intialPos.placeName, snippet: "My Location"),
        position: userIntialLocation,
        markerId: MarkerId("userIntialLocationId"));

    Marker finalDestinationLocationMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(
            title: finalPos.placeName, snippet: "My Destination Location"),
        position: finalDestinationLocation,
        markerId: MarkerId("finalDestinationLocationId"));

    setState(() {
      markerSet.add(userIntialLocationMarker);
      markerSet.add(finalDestinationLocationMarker);
    });

    Circle userIntialLocationCircle = Circle(
      fillColor: Colors.blue,
      center: userIntialLocation,
      radius: 12,
      strokeColor: Colors.blueAccent,
      strokeWidth: 4,
      circleId: CircleId("userIntialLocationId"),
    );

    Circle finalDestinationLocationCircle = Circle(
      fillColor: Colors.green,
      center: finalDestinationLocation,
      radius: 12,
      strokeColor: Colors.greenAccent,
      strokeWidth: 4,
      circleId: CircleId("FinalDestinationLocationId"),
    );

    setState(() {
      circleSet.add(userIntialLocationCircle);
      circleSet.add(finalDestinationLocationCircle);
    });
  }
}
