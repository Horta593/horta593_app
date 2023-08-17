import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:horta593app/screens/map/bloc/location_bloc.dart';
import 'package:horta593app/widgets/custom_button.dart';
import 'package:horta593app/widgets/text_title.dart';

import '../../constants/global_variables.dart';

// ignore: must_be_immutable
class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late GoogleMapController _controller;
  final LatLng _center = const LatLng(37.42976302006848, -122.0865985751152);
  Set<Marker> _markers = Set<Marker>();
  String info = "";
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();

    _setMarker(_center);
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(Marker(markerId: const MarkerId("marker"), position: point));
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  Future<Position> _getCurrentLocation() async {
    print("_getCurrentLocation");

    bool serviceEnable;
    LocationPermission permission;

    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
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
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationBloc()..add(const LocationRequestEvent()),
      child: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state is LocationSuccesState) {
            return _bodyExistsLocation(context, state);
          }
          if (state is LocationEmptyState) {
            return _bodyWithOutLocation(context);
          }

          if (state is LocationUpdatedSuccesState) {
            return _bodyLoadingLocation(context, state);
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }

  void _insertInfo() {
    setState(() {
      info = "Information has been inserted!";
    });
  }

  Widget _bodyWithOutLocation(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: const Text('Selecciona tu ubicacion')),
            body: GoogleMap(
                mapType: MapType.normal,
                markers: _markers,
                zoomControlsEnabled: false,
                onMapCreated: _onMapCreated,
                initialCameraPosition:
                    CameraPosition(target: _center, zoom: 11.0)),
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Colors.red,
              onPressed: () async {
                Position position = await _getCurrentLocation();

                bool confirmChange = await _onBackButtonPressed(
                    context,
                    "Location",
                    "We will update your address. Are you sure to change it?");

                _updateLocation(context, confirmChange, position);
              },
              label: const Text("Ups! Update your location."),
              icon: const Icon(Icons.location_history),
            )));
  }

  Widget _bodyLoadingLocation(
      BuildContext context, LocationUpdatedSuccesState state) {
    double lat = state.pos.latitude;
    double long = state.pos.longitude;

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: const Text('Selecciona tu ubicacion')),
            body: GoogleMap(
                mapType: MapType.normal,
                markers: _markers,
                zoomControlsEnabled: false,
                onMapCreated: _onMapCreated,
                initialCameraPosition:
                    CameraPosition(target: LatLng(lat, long), zoom: 11.0)),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                // setState(() {
                //   _center = LatLng(,);
                // });
                // Position position = await _getCurrentLocation();
                // bool confirmChange =
                //     await _onBackButtonPressed(context, "", "");
                // _updateLocation(context, confirmChange, position);
              },
              label: const Text("Your Location"),
              icon: const Icon(Icons.location_history),
            )));
  }

  Widget _bodyExistsLocation(BuildContext context, LocationSuccesState state) {
    double lat = double.parse(state.position.latitude);
    double long = double.parse(state.position.longitude);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: const Text('Tu ubicacion')),
            body: GoogleMap(
                mapType: MapType.normal,
                markers: <Marker>{
                  Marker(
                      markerId: MarkerId("You are here"),
                      position: LatLng(lat, long))
                },
                zoomControlsEnabled: false,
                onMapCreated: _onMapCreated,
                initialCameraPosition:
                    CameraPosition(target: LatLng(lat, long), zoom: 11.0)),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                Position position = await _getCurrentLocation();
                bool confirmChange = await _onBackButtonPressed(context,
                    "Update Location", "Are you want to change your address?");
                _updateLocation(context, confirmChange, position);
              },
              label: const Text("Your Location"),
              icon: const Icon(Icons.location_history),
            )));
  }

  _onBackButtonPressed(BuildContext context, String title, String text) async {
    bool confirm = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text("YES")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text("NO"))
            ],
          );
        });

    return confirm ?? false;
  }

  void _updateLocation(
      BuildContext context, bool confirmChange, Position position) {
    if (confirmChange) {
      _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 11)));

      _markers.clear();
      _markers.add(Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(position.latitude, position.longitude)));

      _showBottomSheet(context);
      context.read<LocationBloc>().add(UpdatedLocationUserEvent(position, ""));
      setState(() {});
    } else {
      print('No cambio!');
    }
  }

  void _showBottomSheet(BuildContext context) {
    int _counter = 0;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext con3ext) {
        return Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: FractionallySizedBox(
                heightFactor: 0.2,
                child: Container(
                    decoration: const BoxDecoration(
                      color: GlobalVariables.primarybackground,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(top: 20, left: 15, right: 15),
                          child: Column(
                            children: [
                              TitleCustom(title: "Name your Location"),
                              FormBuilder(
                                  key: _formKey,
                                  child: FormBuilderTextField(
                                      style: const TextStyle(
                                          color:
                                              GlobalVariables.whitebackgound),
                                      name: 'location name',
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(context),
                                        FormBuilderValidators.minLength(
                                            context, 3),
                                        FormBuilderValidators.match(
                                            context, "^[a-zA-Z]{1,8}\$",
                                            errorText:
                                                "Name cannot include numbers."),
                                      ]))),
                              CustomButton(
                                  text: "Name your Location",
                                  onTap: () {
                                    if (_formKey.currentState!
                                        .saveAndValidate()) {
                                      var nameValue =
                                          _formKey.currentState!.value['name'];
                                      print(nameValue);
                                    }
                                  })
                            ],
                          ),
                        )
                      ],
                    ))));
      },
    );
  }
}
