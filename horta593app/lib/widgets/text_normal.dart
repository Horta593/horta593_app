import 'package:flutter/material.dart';

import '../constants/global_variables.dart';

class NormalText extends StatelessWidget {
  final String text;
  final int? sizeT;
  const NormalText({Key? key, required this.text, this.sizeT})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: GlobalVariables.whiteletter),
    );
  }
}
