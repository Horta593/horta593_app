import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/payment_bloc.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreen();
}

class _PaymentScreen extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) => ListView(
              children: [const Text('Your payment content here')],
            ));
    // const Scaffold(
    //   body: Center(
    //     child: Text('Your payment content here'),
    //   ),
    // );
  }
}
