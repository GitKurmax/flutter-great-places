import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapsScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapsScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 37.422, longtitude: -122.084),
      this.isSelecting = false});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  LatLng? _pickedLocation;

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
                onPressed: _pickedLocation == null
                    ? null
                    : () {
                        Navigator.of(context).pop(_pickedLocation);
                      },
                icon: Icon(Icons.check))
        ],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longtitude),
          zoom: 10,
        ),
        onTap: widget.isSelecting ? _selectPosition : null,
        markers: (_pickedLocation == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                    markerId: MarkerId('m1'),
                    position: _pickedLocation ??
                        LatLng(widget.initialLocation.latitude,
                            widget.initialLocation.longtitude))
              },
      ),
    );
  }
}
