import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// ignore: must_be_immutable
class MapSample extends StatefulWidget {
  List<String> location;
  MapSample({Key? key, required this.location}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late GoogleMapController _controller;
  late double lat;
  late double long;
  String locationMessage = 'Latitud: X, Longitud: Y';
  late LatLng _center;
  final Location _location = Location();
  Set<Marker> _markers = {};
  bool _mapCanDrag = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    if (widget.location.isNotEmpty) {
      _center =
          LatLng(widget.location[0] as double, widget.location[1] as double);
    } else {
      _center = LatLng(37.42976302006848, -122.0865985751152);
    }
    _initLocation();
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions are denied.");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permissions are permanently denied, we cannot request.");
    }
    return await Geolocator.getCurrentPosition();
  }

  // void _liveLocation() {
  //   // LocationSettings locationSettings =
  //   //     LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 100);

  //   Geolocator.getPositionStream(locationSettings: locationSettings)
  //       .listen((Position position) {
  //     lat = position.latitude;
  //     long = position.longitude;

  //     setState(() {
  //       _center = LatLng(lat, long);
  //       _markers.add(Marker(
  //           markerId: MarkerId('current_location'),
  //           position: _center,
  //           draggable: true,
  //           infoWindow: const InfoWindow(title: "Tu ubicacion"),
  //           onDragStart: (position) {
  //             _mapCanDrag = false;
  //           },
  //           onDragEnd: (newPosition) {
  //             print(
  //                 "Posicion: ${newPosition.latitude}, ${newPosition.longitude}");
  //             setState(() {
  //               lat = newPosition.latitude;
  //               long = newPosition.longitude;
  //               _center = LatLng(lat, long);
  //               _mapCanDrag = true;
  //             });
  //           }));
  //       locationMessage =
  //           'Latitud: ${lat.toString()}, longitude: ${long.toString()}';
  //     });
  //   });
  // }

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
            setState(() {
              print(
                  "Posicion: ${newPosition.latitude}, ${newPosition.longitude}");
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
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        markers: _markers,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 15.0,
        ),
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(
            () => _mapCanDrag
                ? ScaleGestureRecognizer()
                : EagerGestureRecognizer(),
          ),
        },
        //   ),
      ),
    ));
  }
}
