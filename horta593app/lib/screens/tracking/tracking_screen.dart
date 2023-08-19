import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horta593app/constants/global_variables.dart';
import 'package:horta593app/screens/tracking/bloc/tracking_bloc.dart';

class TrackingScreen extends StatefulWidget {
  static const String routeName = '/route-tracking';
  TrackingScreen({Key? key}) : super(key: key);

  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  List<OrderStatus> orderStatuses = [
    OrderStatus("Order Sent"),
    OrderStatus("Order In Process"),
    OrderStatus("Order Ready"),
    OrderStatus("Order Completed"),
  ];
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackingBloc, TrackingState>(builder: (context, state) {
      print(state);
      if (state is TrackingSuccessPayment) {
        return const Center(
            child: Text(
          "Processing your order...",
          style: TextStyle(color: GlobalVariables.whiteletter),
        ));
      }
      if (state is OrderSentState) {
        return Center(
            child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: orderStatuses.length,
              itemBuilder: (context, index) {
                var status = orderStatuses[index];
                if (index == 0) {
                  return ListTile(
                      leading: const Icon(Icons.check_circle,
                          color: GlobalVariables.greenHorta),
                      title: Text(
                        status.status,
                        style:
                            const TextStyle(color: GlobalVariables.whiteletter),
                      ));
                }
                return ListTile(
                  leading: const Icon(Icons.check_circle,
                      color: GlobalVariables.yellow),
                  title: Text(
                    status.status,
                    style: const TextStyle(color: GlobalVariables.whiteletter),
                  ),
                );
              },
            ))
          ],
        ));
      }
      if (state is OrderProcessState) {
        return Center(
            child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: orderStatuses.length,
              itemBuilder: (context, index) {
                var status = orderStatuses[index];
                if (index <= 1) {
                  return ListTile(
                      leading: const Icon(Icons.check_circle,
                          color: GlobalVariables.greenHorta),
                      title: Text(
                        status.status,
                        style:
                            const TextStyle(color: GlobalVariables.whiteletter),
                      ));
                }
                return ListTile(
                  leading: const Icon(Icons.check_circle,
                      color: GlobalVariables.yellow),
                  title: Text(
                    status.status,
                    style: const TextStyle(color: GlobalVariables.whiteletter),
                  ),
                );
              },
            ))
          ],
        ));
      }

      if (state is OrderReadyState) {
        return Center(
            child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: orderStatuses.length,
              itemBuilder: (context, index) {
                var status = orderStatuses[index];
                if (index <= 2) {
                  return ListTile(
                      leading: const Icon(Icons.check_circle,
                          color: GlobalVariables.greenHorta),
                      title: Text(
                        status.status,
                        style:
                            const TextStyle(color: GlobalVariables.whiteletter),
                      ));
                }
                return ListTile(
                  leading: const Icon(Icons.check_circle,
                      color: GlobalVariables.yellow),
                  title: Text(
                    status.status,
                    style: const TextStyle(color: GlobalVariables.whiteletter),
                  ),
                );
              },
            ))
          ],
        ));
      }

      if (state is OrderCompletedState) {
        return Center(
            child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: orderStatuses.length,
              itemBuilder: (context, index) {
                var status = orderStatuses[index];
                if (index <= 3) {
                  return ListTile(
                      leading: const Icon(Icons.check_circle,
                          color: GlobalVariables.greenHorta),
                      title: Text(
                        status.status,
                        style:
                            const TextStyle(color: GlobalVariables.whiteletter),
                      ));
                }
                return ListTile(
                  leading: const Icon(Icons.check_circle,
                      color: GlobalVariables.yellow),
                  title: Text(
                    status.status,
                    style: const TextStyle(color: GlobalVariables.whiteletter),
                  ),
                );
              },
            ))
          ],
        ));
      }

      if (state is TrackingOrderSuccessPayment) {
        return Center(
            child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: orderStatuses.length,
              itemBuilder: (context, index) {
                var status = orderStatuses[index];
                return ListTile(
                  leading: const Icon(Icons.check_circle,
                      color: GlobalVariables.yellow),
                  title: Text(
                    status.status,
                    style: const TextStyle(color: GlobalVariables.whiteletter),
                  ),
                );
              },
            ))
          ],
        ));
      }
      return const Center(
        child: Text(
          "UPS! Lost Connection",
          style: TextStyle(color: GlobalVariables.whiteletter),
        ),
      );
    });
  }
}

class OrderStatus {
  final String status;

  OrderStatus(this.status);
}
