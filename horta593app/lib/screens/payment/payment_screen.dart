import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  PickedFile? _imageFile;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    // PickedFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = image as PickedFile?;
    });
  }

  Widget _buildPaymentOrderDetail() {
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
              color: Colors.white,
              fontSize: 20,
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
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Card(
          elevation: 4.0, // optional, to provide some shadow
          color: const Color.fromRGBO(
              46, 44, 49, 1.0), // to provide a dark background
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Account Name: [Your Account Name]",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, color: Colors.white),
                      onPressed: () {
                        Clipboard.setData(
                            const ClipboardData(text: "[Your Account Name]"));
                        // Optionally, provide user feedback that the text has been copied.
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Bank: [Your Bank Name]",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, color: Colors.white),
                      onPressed: () {
                        Clipboard.setData(
                            const ClipboardData(text: "[Your Bank Name]"));
                        // Optionally, provide user feedback that the text has been copied.
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Account Number: [Your Account Number]",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, color: Colors.white),
                      onPressed: () {
                        Clipboard.setData(
                            const ClipboardData(text: "[Your Account Number]"));
                        // Optionally, provide user feedback that the text has been copied.
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "IBAN: [Your IBAN]",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, color: Colors.white),
                      onPressed: () {
                        Clipboard.setData(
                            const ClipboardData(text: "[Your IBAN]"));
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
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14), // Font size 14 and color white
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
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text("Subir Foto"),
                ),
                if (_imageFile != null) Image.file(File(_imageFile!.path)),
              ],
            ),
          ),
        )
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
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) => ListView(
          children: [_buildPaymentOrderDetail()],
        ),
      ),
    );
  }
}
