import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'package:location/location.dart';

import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview (double lat, double lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longtitude: lng);

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getUserLocation() async {
    final locData = await Location().getLocation();
    _showPreview(locData.latitude!, locData.longitude!);

    widget.onSelectPlace(locData.latitude, locData.longitude);
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapsScreen(isSelecting: true)));
    if (selectedLocation == null) {
      return;
    }

    _showPreview(selectedLocation.latitude, selectedLocation.longitude);

    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _previewImageUrl == null
              ? Text(
                  'No location chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current location'),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Select on map'),
            )
          ],
        )
      ],
    );
  }
}
