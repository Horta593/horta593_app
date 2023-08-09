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
  late LatLng _center = LatLng(37.4219983, -122.084);
  final Location _location = Location();
  Set<Marker> _markers = {};
  bool _mapCanDrag = true;

  @override
  void initState() {
    super.initState();
    _initLocation();
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
      _markers.add(Marker(
          markerId: MarkerId('current_location'),
          position: _center,
          draggable: true,
          infoWindow: const InfoWindow(title: "Tu ubicacion"),
          onDragStart: (position) {
            _mapCanDrag = false;
          },
          onDragEnd: (newPosition) {
            print(
                "Posicion: ${newPosition.latitude}, ${newPosition.longitude}");
            setState(() {
              _center = newPosition;
              _mapCanDrag = true;
            });
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Selecciona tu ubicacion')),
        body: _center == null
            ? const Center(child: CircularProgressIndicator())
            : GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                },
                markers: _markers,
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
