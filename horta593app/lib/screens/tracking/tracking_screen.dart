import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horta593app/constants/global_variables.dart';
import 'package:horta593app/screens/tracking/bloc/tracking_bloc.dart';

class TrackingScreen extends StatelessWidget {
  static const String routeName = '/route-tracking';
  TrackingScreen({Key? key}) : super(key: key);

  List<OrderStatus> orderStatuses = [
    OrderStatus(
        "Order Received", DateTime.now().subtract(const Duration(days: 3))),
    OrderStatus(
        "Order Processed", DateTime.now().subtract(const Duration(days: 2))),
    OrderStatus("Shipped", DateTime.now().subtract(const Duration(days: 1))),
    OrderStatus("Out for Delivery", DateTime.now()),
    OrderStatus("Delivered", DateTime.now().add(const Duration(hours: 5))),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackingBloc, TrackingState>(builder: (context, state) {
      if (state is TrackingSuccessPayment) {
        return Center(
            child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: orderStatuses.length,
              itemBuilder: (context, index) {
                var status = orderStatuses[index];
                return ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: Text(
                    status.status,
                    style: TextStyle(color: GlobalVariables.whiteletter),
                  ),
                  subtitle: Text(status.date.toString()),
                );
              },
            ))
          ],
        ));
      }
      return const Center(
        child: Text(
          "Server Error",
          style: TextStyle(color: GlobalVariables.whiteletter),
        ),
      );
    });
  }
}

class OrderStatus {
  final String status;
  final DateTime date;

  OrderStatus(this.status, this.date);
}
