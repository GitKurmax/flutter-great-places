import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static String routeName = '/add-place';
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longtitude: lng);
  }

  void _savePlace() {
    if(_titleController.text.isEmpty || _pickedImage == null || _pickedLocation == null) {
      return;
    }

    Provider.of<GreatPlaces>(context, listen: false).addPlace(_titleController.text, _pickedImage!, _pickedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Title'
                  ),
                  controller: _titleController,
                ),
                SizedBox(height: 10),
                ImageInput(_selectImage),
                SizedBox(height: 10,),
                LocationInput(_selectPlace)
              ],
            ),
          )),
          ElevatedButton.icon(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: MaterialStateProperty.all(Colors.black),
              backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.secondary),
            ),
            onPressed: _savePlace,
            label: Text('Add place'),
            icon: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
