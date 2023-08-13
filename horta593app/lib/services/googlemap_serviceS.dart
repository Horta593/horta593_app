import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late GoogleMapController _controller;
  late LatLng _center = const LatLng(37.4219983, -122.084);
  final Location _location = Location();
  Set<Marker> markers = {};
  bool _mapCanDrag = true;

  @override
  void initState() {
    super.initState();
    _initLocation();

    setState(() {
      markers.add(Marker(
        markerId: const MarkerId('current_location'),
        position: _center,
        draggable: true,
        infoWindow: const InfoWindow(title: "Tu ubicacion"),
        onDragStart: (position) {
          _mapCanDrag = false;
        },
        onDragEnd: (value) {
          _showConfirmationDialog(value);
        },
      ));
    });
  }

  _onConfirmChange() {
    // Handle the confirmation action here, e.g., update the backend
    print('Change confirmed!');
  }

  _showConfirmationDialog(LatLng newposition) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: const Text('Do you want to change your address?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                _onConfirmChange();

                setState(() {
                  _center = newposition; // <-- Use the new position here
                });

                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _initLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await _location.getLocation();

    setState(() {
      _center = LatLng(_locationData.latitude!, _locationData.longitude!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Selecciona tu ubicacion')),
        body: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
          markers: markers,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 15.0,
          ),
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
            Factory<OneSequenceGestureRecognizer>(
              () => _mapCanDrag
                  ? ScaleGestureRecognizer()
                  : EagerGestureRecognizer(),
            ),
          ].toSet(),
        ),
      ),
    );
  }
}
