import 'package:geolocator/geolocator.dart';

import 'requestAssistant.dart';

class AssistantMethods {
  static Future<String> searchCoordinateAddress(
      Position position, context) async {
    String placeAddress = '';
    String a1, a2, a3, a4;
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyD-yOv-CmxUNv9PQaZaDTAvEiyKVlMY5cE";
    Uri temp = Uri(
      host: "https://maps.googleapis.com/",
      path: "maps/api/geocode/json",
      query:
          "?latlng=${position.latitude},${position.longitude}&key=AIzaSyD-yOv-CmxUNv9PQaZaDTAvEiyKVlMY5cE",
    );

    var response = await RequestAssistant.getRequest(temp);

    if (response != "Failed") {
      a1 = response["results"][0]["address_components"][0]["long_name"];
      a2 = response["results"][0]["address_components"][1]["long_name"];
      a3 = response["results"][0]["address_components"][2]["long_name"];
      a4 = response["results"][0]["address_components"][3]["long_name"];

      placeAddress = a1 + ", " + a2 + ", " + a3 + ", " + a4;
      print("This is your Address" + placeAddress);
    } else {
      print("NOOOOOOOOTTTTTTTTT FOOOOOOOOOUUUUUUUNNNNNNNND");
    }

    return placeAddress;
  }
}
