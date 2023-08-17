import 'package:flutter/material.dart';

import '../constants/global_variables.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.arrow_back,
      color: GlobalVariables.whiteletter,
    );
  }
}
