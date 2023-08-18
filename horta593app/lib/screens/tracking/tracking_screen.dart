import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horta593app/screens/tracking/bloc/tracking_bloc.dart';

class TrackingScreen extends StatelessWidget {
  TrackingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrackingBloc(),
      child: Column(),
    );
  }
}
