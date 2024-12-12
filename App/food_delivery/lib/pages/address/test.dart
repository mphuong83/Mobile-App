import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:flutter/material.dart';

class OpenStreetMapTutorial extends StatefulWidget {
  @override
  State<OpenStreetMapTutorial> createState() => _OpenStreetMapTutorialState();
}

class _OpenStreetMapTutorialState extends State<OpenStreetMapTutorial> {
  String address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: OpenStreetMapSearchAndPick(
        buttonColor: Colors.blue,
        buttonText: 'Set Current Location',
        onPicked: (pickedData) {
          setState(() {
            // address = pickedData.address;
            print(pickedData.latLong.latitude);
            print(pickedData.latLong.longitude);
            print(pickedData.address);
          });
        },
      ),
    );
  }
}