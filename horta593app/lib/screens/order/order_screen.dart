import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horta593app/screens/order/bloc/order_bloc.dart';
import 'bloc/order_bloc.dart';
import '../../constants/global_variables.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreen();
}

class _OrderScreen extends State<OrderScreen> {
  Widget _buildOrderStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Added for left alignment
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Tu Orden",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Número de Orden: ",
                        style: TextStyle(
                          color: GlobalVariables.greenHorta,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "12345", //se obtiene del
                        style: TextStyle(
                          color: GlobalVariables.greenHorta,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),

        // Removed Delivery and Pickup buttons
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Detalle de orden",
            style: TextStyle(
              color: GlobalVariables.greenHorta,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              margin: const EdgeInsets.all(16.0),
              elevation: 4.0,
              color: const Color.fromRGBO(
                  46, 44, 49, 1.0), // Transparent background color
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                    color: Colors.grey, width: 0.5), // Grey border
                borderRadius: BorderRadius.circular(8.0),
              ),

              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Subtotal",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      )),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Subtotal Value",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "IVA",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      )),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "IVA Value",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Servicio + Envio",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      )),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Servicio + Envio Value",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Total",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "TotalEnvio Value",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        // This Expanded widget makes sure that the ListView takes up all available space
        Expanded(
          child: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderInitialState) {
                return ListView(
                  children: [_buildOrderStatus()],
                );
              }
              // You can add other conditional returns based on different states if needed.
              return const Center(
                child: Text(
                  "Order empty!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
