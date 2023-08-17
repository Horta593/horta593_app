import 'package:flutter/material.dart';

import '../constants/global_variables.dart';

class NormalText extends StatelessWidget {
  final String text;
  final double? sizeT;
  final bool trunc;
  const NormalText(
      {Key? key, required this.text, this.sizeT, this.trunc = true})
      : super(key: key);

  String truncateWithEllipsis(String text, int cutOff) {
    return (text.length <= cutOff) ? text : '${text.substring(0, cutOff)}...';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              trunc ? truncateWithEllipsis(text, 40) : text,
              style: TextStyle(
                  color: GlobalVariables.whiteletter, fontSize: sizeT),
            ))
      ],
    );
  }
}
