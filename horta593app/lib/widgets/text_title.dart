import 'package:flutter/material.dart';

import '../constants/global_variables.dart';

class TitleCustom extends StatelessWidget {
  final String title;
  final double? sizeT;
  const TitleCustom({Key? key, required this.title, this.sizeT = 15})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: sizeT,
                  color: GlobalVariables.greenHorta,
                  fontWeight: FontWeight.bold),
              maxLines: 3,
              softWrap: true,
            ))
      ],
    );
  }
}
