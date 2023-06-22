import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapPickerWidget extends StatefulWidget {
  @override
  _MapPickerWidgetState createState() => _MapPickerWidgetState();
}

class _MapPickerWidgetState extends State<MapPickerWidget> {
  GoogleMapController? mapController;

  String? searchAddr;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pick an Address'),
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: onMapCreated,
              // options: GoogleMapOptions(
              //     cameraPosition: CameraPosition(
              //         target: LatLng(40.7128, -74.0060), zoom: 10.0)),
              initialCameraPosition:
                  CameraPosition(target: LatLng(40.7128, -74.0060), zoom: 10.0),
            ),
            // Positioned(
            //   top: 30.0,
            //   right: 15.0,
            //   left: 15.0,
            //   child: Container(
            //     height: 250.0,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10.0),
            //         color: Colors.white),
            //     // child: TextField(
            //     //   decoration: InputDecoration(
            //     //       hintText: 'Enter Address',
            //     //       border: InputBorder.none,
            //     //       contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
            //     //       suffixIcon: IconButton(
            //     //           icon: Icon(Icons.search),
            //     //           onPressed: searchandNavigate,
            //     //           iconSize: 30.0)),
            //     //   onChanged: (val) {
            //     //     setState(() {
            //     //       searchAddr = val;
            //     //     });
            //     //   },
            //     // ),
            //   ),
            // )
          ],
        ));
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
}
