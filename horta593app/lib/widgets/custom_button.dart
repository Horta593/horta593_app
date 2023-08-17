import 'package:flutter/material.dart';

import '../../constants/global_variables.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool dark;
  final VoidCallback onTap;
  final double paddingLR;
  const CustomButton(
      {Key? key,
      required this.text,
      this.dark = false,
      required this.onTap,
      this.paddingLR = 80})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dark) {
      return Padding(
        padding: EdgeInsets.only(left: paddingLR, right: paddingLR),
        child: Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: onTap,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      GlobalVariables.primarybackground),
                  shadowColor: MaterialStateProperty.all(
                      GlobalVariables.secondaryColor)),
              child: Text(text),
            )),
      );
    } else {
      return Padding(
          padding: EdgeInsets.only(left: paddingLR, right: paddingLR),
          child: ElevatedButton(
            onPressed: onTap,
            child: Text(text),
          ));
    }
  }
}
