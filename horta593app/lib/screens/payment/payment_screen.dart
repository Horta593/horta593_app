import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horta593app/model/pay_model.dart';
import 'package:horta593app/screens/category/bloc/categories_bloc.dart';
import 'package:horta593app/screens/order/bloc/order_bloc.dart';
import 'package:horta593app/screens/order/order_screen.dart';
import 'package:horta593app/screens/payment/bloc/payment_event.dart';
import 'bloc/payment_bloc.dart';
import '../../constants/global_variables.dart';
import 'package:image_picker/image_picker.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreen();
}

class _PaymentScreen extends State<PaymentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  XFile? _imageFile;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
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

  // Future<void> _pickImage() async {
  //   final ImagePicker _picker = ImagePicker();
  //   XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  //   // PickedFile? image = await _picker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     _imageFile = image as PickedFile?;
  //   });
  // }

  Widget _buildPaymentOrderDetail(Pay pay) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Added for left alignment
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "Tu Orden",
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
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Método de Pago",
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
                      "Beneficiario: Marmandos Gorotiza",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, color: Colors.white),
                      onPressed: () {
                        Clipboard.setData(
                            const ClipboardData(text: "Marmandos Gorotiza"));
                        // Optionally, provide user feedback that the text has been copied.
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Banco: Banco Bolivariano",
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
                      "Número de cuenta: 0019614578",
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
                      "cédula: 0987654321",
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
            "Datos de Facturación",
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
          child: Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Column(
                children: [
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                      filled: true,
                      fillColor: Colors.transparent,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Cédula',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                      filled: true,
                      fillColor: Colors.transparent,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Correo Electrónico',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                      filled: true,
                      fillColor: Colors.transparent,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
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
              Navigator.pop(
                  context); // This will take you back to the previous screen
            },
          ),
          title: const Padding(
            padding: EdgeInsets.all(8.0), // padding
            child: Row(
              // Row widget
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.place_outlined,
                  color: GlobalVariables.secondaryColor,
                  size: 40.0,
                ),
                SizedBox(
                    width: 10.0), // Some space between the icon and the texts
                Column(
                  // Column for the texts
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Casa",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          fontFamily: "Lato"),
                    ),
                    Text(
                      "Av. Francisco de Orellana 562",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: "Lato"),
                    )
                  ],
                ),
              ],
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // This Expanded widget makes sure that the ListView takes up all available space
            Expanded(
              child: BlocBuilder<PaymentBloc, PaymentState>(
                builder: (context, state) {
                  if (state is PaymentReadyState) {
                    return ListView(
                      children: [_buildPaymentOrderDetail(state.newPay)],
                    );
                  }
                  // You can add other conditional returns based on different states if needed.
                  return const Center(
                      child: Text("Waiting for payment details..."));
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    GlobalVariables.secondaryColor,
                  ),
                ),
                child: const Text("Pagar"),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ));
  }
}
