import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horta593app/model/cart_model.dart';
import 'bloc/order_bloc.dart';
import '../../constants/global_variables.dart';
import '../../model/product_model.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreen();
}

class _OrderScreen extends State<OrderScreen> {
  Widget _buildOrder(Cart cart) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                  children: [Text("here")],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: _buildOrder(state.cart),
            ),
          ],
        );
      },
    );
  }
}
