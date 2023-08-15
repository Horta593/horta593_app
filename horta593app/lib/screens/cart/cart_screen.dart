import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horta593app/model/pay_model.dart';
import 'package:horta593app/screens/payment/bloc/payment_bloc.dart';
import 'package:horta593app/screens/payment/bloc/payment_event.dart';
import '../../model/cart_item_model.dart';
import '../payment/payment_screen.dart';
import 'bloc/cart_bloc.dart';
import '../../constants/global_variables.dart';
import '../../model/product_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreen();
}

class _CartScreen extends State<CartScreen> {
  double calculateTotal(List<CartItem> items) {
    double total = 0.0;
    for (var item in items) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  Widget _buildCartCard(CartItem items) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(items.product.imageurl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              items.product.name,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(53, 143, 50, 1.0)),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              items.product.description,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(180, 180, 180, 1.0),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Ink(
                                      child: IconButton(
                                        color: const Color.fromRGBO(
                                            212, 178, 36, 1.0),
                                        onPressed: () {
                                          // Decrease quantity logic
                                          // final cartBloc =
                                          //     context.read<CartBloc>();
                                          // cartBloc.add(UpdateQuantity(
                                          //     items, items.quantity));
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),
                                    ),
                                    Text(items.quantity.toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        )),
                                    Ink(
                                      child: IconButton(
                                        color: const Color.fromRGBO(
                                            212, 178, 36, 1.0),
                                        onPressed: () {},
                                        icon: const Icon(Icons.add),
                                      ),
                                    ) //poner la cantidad
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          color: Colors.white,
                          onPressed: () {
                            // Delete item logic
                            final cartBloc = context.read<CartBloc>();
                            cartBloc.add(RemoveProduct(items.product));
                          },
                          icon: const Icon(Icons.close),
                        ),
                        // Text(
                        //     '\$${(product.price).toStringAsFixed(2)}'), //* quantity
                      ],
                    ),
                  ],
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
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: ListView(
                children: state.items.map((e) => _buildCartCard(e)).toList(),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              color: Color.fromRGBO(58, 65, 57, 1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal: \$${calculateTotal(state.items).toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: GlobalVariables.greenHorta),
                    onPressed: () {
                      // Place order logic
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider<PaymentBloc>(
                            create: (context) => PaymentBloc()
                              ..add(InitializePayment(
                                  pay: Pay(
                                      name: "",
                                      personalId: "",
                                      email: "",
                                      shoppingCart: state.items))),
                            child: const PaymentScreen(),
                          ),
                        ),
                      );
                    },
                    child: const Text('Pagar'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
