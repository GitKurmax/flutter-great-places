import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';


class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longtitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longtitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red|label:A|$latitude,$longtitude&key=${dotenv.env['GOOGLE_MAPS_API_KEY']}';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=${dotenv.env['GOOGLE_MAPS_API_KEY']}');
    final response = await http.get(url);

    return jsonDecode(response.body)['results'][0]['formatted_address'];
  }
}
