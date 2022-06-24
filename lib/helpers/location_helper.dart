const GOOGLE_MAPS_API_KEY = 'AIzaSyBbDWXP_GbECPggWsX6p78nlSgl4--zqEc';

class LocationHelper {
  static String generateLocationPreviewImage({required double latitude, required double longtitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longtitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red|label:A|$latitude,$longtitude&key=$GOOGLE_MAPS_API_KEY';
  }
}