import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/cart_item_model.dart';
import 'bloc/payment_bloc.dart';
import '../../constants/global_variables.dart';
import '../../model/product_model.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreen();
}

class _PaymentScreen extends State<PaymentScreen> {
  Widget _buildPaymentOrderDetail() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Tu Orden",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(children: [
          ElevatedButton(onPressed: () {}, child: const Text("Delivery")),
          const SizedBox(width: 4),
          ElevatedButton(onPressed: () {}, child: const Text("Pick up")),
        ]),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Detalle de orden",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: const Color.fromRGBO(46, 44, 49, 1.0),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
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
                            fontWeight: FontWeight.normal,
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
                            fontWeight: FontWeight.normal,
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
                            fontWeight: FontWeight.normal,
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
                            fontWeight: FontWeight.normal,
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
                            fontWeight: FontWeight.normal,
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
                            fontWeight: FontWeight.normal,
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) => ListView(
              children: [_buildPaymentOrderDetail()],
            ));
  }
}
