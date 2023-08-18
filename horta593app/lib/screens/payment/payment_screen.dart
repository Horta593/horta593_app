import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:horta593app/model/pay_model.dart';
import 'package:horta593app/screens/payment/bloc/payment_event.dart';
import 'package:horta593app/screens/tracking/bloc/tracking_bloc.dart';
import 'package:horta593app/screens/tracking/tracking_screen.dart';
import 'package:horta593app/widgets/text_normal.dart';
import '../../widgets/text_title.dart';
import '../home/base_screen.dart';
import 'bloc/payment_bloc.dart';
import '../../constants/global_variables.dart';
import 'package:image_picker/image_picker.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreen();
}

class _PaymentScreen extends State<PaymentScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  Future<void> _pickImage() async {
    print("_pickImage");

    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
    if (_imageFile != null) {
      Image.file(File(_imageFile!.path));
      // Simulate a successful upload
      Fluttertoast.showToast(
          msg: "File uploaded successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "File upload failed!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  double iva = 0.12;
  double service = 3.0;
  double calculateTotal(double subTotal) {
    double total = 0.0;
    double res = (subTotal * iva);
    total = subTotal + res + service;
    return total;
  }

  Widget _buildPaymentOrderDetail(double subtotal, double total) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Added for left alignment
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "Your Order",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // Removed Delivery and Pickup buttons
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Order Detail",
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

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
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
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          subtotal.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Tax",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      )),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "12%",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Service + Delivery",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      )),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "3.00",
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
                      const Expanded(
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
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          calculateTotal(subtotal).toString(),
                          style: const TextStyle(
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
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Payment method",
            style: TextStyle(
              color: GlobalVariables.greenHorta,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.all(16.0),
          elevation: 4.0, // optional, to provide some shadow
          color: const Color.fromRGBO(
              46, 44, 49, 1.0), // to provide a dark background
          shape: RoundedRectangleBorder(
            side:
                const BorderSide(color: Colors.grey, width: 0.5), // Grey border
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Account owner: Marmandos Gorotiza",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, color: Colors.white),
                      onPressed: () {
                        Clipboard.setData(
                            const ClipboardData(text: "Jonathan Gorotiza"));
                        // Optionally, provide user feedback that the text has been copied.
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Bank: Banco Bolivariano",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, color: Colors.white),
                      onPressed: () {
                        Clipboard.setData(
                            const ClipboardData(text: "Banco Bolivariano"));
                        // Optionally, provide user feedback that the text has been copied.
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Account number: 0019614578",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, color: Colors.white),
                      onPressed: () {
                        Clipboard.setData(
                            const ClipboardData(text: "0019614578"));
                        // Optionally, provide user feedback that the text has been copied.
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "National ID: 0987654321",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, color: Colors.white),
                      onPressed: () {
                        Clipboard.setData(
                            const ClipboardData(text: "0987654321"));
                        // Optionally, provide user feedback that the text has been copied.
                      },
                    ),
                  ],
                ),
                // ... rest of the rows are similar
              ],
            ),
          ),
        ),

        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Billing Information",
            style: TextStyle(
              color: GlobalVariables.greenHorta,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.all(16.0),
          elevation: 4.0,
          color: const Color.fromRGBO(
              46, 44, 49, 1.0), // Transparent background color
          shape: RoundedRectangleBorder(
            side:
                const BorderSide(color: Colors.grey, width: 0.5), // Grey border
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: FormBuilder(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Column(
                children: [
                  NormalText(text: "Name"),
                  FormBuilderTextField(
                      style: const TextStyle(
                          color: GlobalVariables.whitebackgound),
                      name: 'name',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.minLength(context, 3),
                        FormBuilderValidators.match(context, "^[a-zA-Z]{1,8}\$",
                            errorText: "Must be letters")
                      ])),
                  const SizedBox(height: 8),
                  NormalText(text: "National ID"),
                  FormBuilderTextField(
                      style: const TextStyle(
                          color: GlobalVariables.whitebackgound),
                      name: 'nationalid',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.maxLength(context, 10),
                        FormBuilderValidators.minLength(context, 10),
                        FormBuilderValidators.numeric(context)
                      ])),
                  const SizedBox(height: 8),
                  NormalText(text: "Email"),
                  FormBuilderTextField(
                      style: const TextStyle(
                          color: GlobalVariables.whitebackgound),
                      name: 'email',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.email(context)
                      ])),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Spacer(), // Pushes content towards the center
                      if (_imageFile != null) ...[
                        Image.file(File(_imageFile!.path),
                            width: 80,
                            height:
                                80), // You can adjust the width and height accordingly
                        const SizedBox(
                            width:
                                10), // Some space between the image and the button
                      ],
                      IconButton(
                        icon: const Icon(Icons.file_upload),
                        color: GlobalVariables.secondaryColor,
                        onPressed: _pickImage,
                      ),
                      const Spacer(), // Pushes content towards the end
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          backgroundColor: GlobalVariables.primarybackground,
          leading: BackButton(
            color: GlobalVariables.secondaryColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<PaymentBloc, PaymentState>(
                builder: (context, state) {
                  if (state is PaymentReadyState) {
                    return ListView(
                      children: [
                        _buildPaymentOrderDetail(state.subtotal, state.total),
                        _confirmPayment(context, state)
                      ],
                    );
                  }
                  return const Center(
                      child: Text("Waiting for payment details..."));
                },
              ),
            )
          ],
        ));
  }

  Widget _confirmPayment(BuildContext context, PaymentReadyState state) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // if (_formKey.currentState!.saveAndValidate()) {
            context
                .read<TrackingBloc>()
                .add(TrackingInitialEvent(state.idOrder));

            Navigator.pop(context);
            // }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              GlobalVariables.secondaryColor,
            ),
          ),
          child: const Text("Confirm purchase"),
        ));
  }
}
