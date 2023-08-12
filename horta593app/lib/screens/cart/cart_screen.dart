import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horta593app/screens/order/order_screen.dart';
import '../../model/cart_item_model.dart';
import 'bloc/cart_bloc.dart';
import '../../constants/global_variables.dart';
import '../../model/product_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreen();
}

class _CartScreen extends State<CartScreen> {
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
                                  color: GlobalVariables.greenHorta),
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
                                        color: GlobalVariables.yellow,
                                        onPressed: () {
                                          // Decrease quantity logic
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),
                                    ),
                                    Text(items.product.price.toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        )),
                                    Ink(
                                      child: IconButton(
                                        color: GlobalVariables.yellow,
                                        onPressed: () {
                                          // Increase quantity logic
                                        },
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const OrderScreen()),
                            );
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
              child: ListView.builder(
                itemCount: state.shoppingCart.length,
                itemBuilder: (context, i) {
                  List lst =
                      state.shoppingCart.map((e) => _buildCartCard(e)).toList();
                  return lst[i];
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              color: Color.fromRGBO(58, 65, 57, 1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text(
                  //   'Subtotal: \$${calculateTotal(state.items).toStringAsFixed(2)}',
                  //   style: const TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: GlobalVariables.greenHorta),
                    onPressed: () {
                      // Place order logic
                      const OrderScreen();
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

// double calculateTotal(CartItem items) {
//   double total = 0;
//   for (var item in items) {
//     total += item.product.price;
//   }
//   return total;
// }
