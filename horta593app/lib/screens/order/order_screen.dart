import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/cart_item_model.dart';
import '../../constants/global_variables.dart';
import '../../model/product_model.dart';
import 'bloc/order_bloc.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreen();
}

class _OrderScreen extends State<OrderScreen> {
  Widget _buildOrderStatus(CartItem cartItem) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              color: const Color.fromRGBO(46, 44, 49, 1.0),
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [Text("Tu orden"), Text("Odern ID - ")],
                  ),
                  Row()
                ],
              ),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {},
        builder: (context, state) {
          return const Column(
            children: [
              Text('Order placed successfully!'),
            ],
          );
        });
  }
}
