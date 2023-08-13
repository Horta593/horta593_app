import 'package:flutter/material.dart';
import 'package:horta593app/constants/global_variables.dart';

class CustomTexField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String header;
  final bool hidden;

  const CustomTexField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.header,
      this.hidden = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        TextFormField(
          obscureText: hidden,
          style: const TextStyle(color: GlobalVariables.whitebackgound),
          controller: controller,
          decoration: InputDecoration(
              labelStyle:
                  const TextStyle(color: GlobalVariables.secondaryColor),
              labelText: header,
              contentPadding: new EdgeInsets.all(10),
              hintStyle: const TextStyle(color: GlobalVariables.greyHorta),
              hintText: hintText,
              border: const OutlineInputBorder(
                  borderSide: BorderSide(
                color: GlobalVariables.secondaryColor,
              )),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                color: GlobalVariables.secondaryColor,
              ))),
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
