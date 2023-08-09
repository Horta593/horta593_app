import 'package:flutter/material.dart';

import '../constants/global_variables.dart';

class TitleCustom extends StatelessWidget {
  final String title;
  const TitleCustom({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 15,
          color: GlobalVariables.greenHorta,
          fontWeight: FontWeight.bold),
      maxLines: 3,
      softWrap: true,
    );
  }
}
