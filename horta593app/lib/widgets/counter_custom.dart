import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horta593app/constants/global_variables.dart';

class CustomCounterWidget extends StatefulWidget {
  final int counterValue;
  final ValueChanged<int> onValueChanged;

  CustomCounterWidget({
    Key? key,
    required this.counterValue,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  _CustomCounterWidgetState createState() => _CustomCounterWidgetState();
}

class _CustomCounterWidgetState extends State<CustomCounterWidget> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _counter = widget.counterValue;
  }

  @override
  void didUpdateWidget(covariant CustomCounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.counterValue != oldWidget.counterValue) {
      _counter = widget.counterValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: GlobalVariables.background2,
                minimumSize: Size(10, 30)),
            onPressed: () {
              setState(() {
                if (_counter >= 1) {
                  _counter -= 1;
                  widget.onValueChanged(_counter);
                }
              });
            },
            child: const Text(
              '-',
              style: TextStyle(color: GlobalVariables.yellow),
            )),
        Container(
            color: GlobalVariables.background2,
            height: 30,
            width: 30,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '$_counter',
                style:
                    TextStyle(color: GlobalVariables.whiteletter, fontSize: 12),
              ),
            )),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: GlobalVariables.background2,
                minimumSize: Size(10, 30)),
            onPressed: () {
              setState(() {
                _counter += 1;
                widget.onValueChanged(_counter);
              });
            },
            child: const Text(
              '+',
              style: TextStyle(color: GlobalVariables.yellow),
            )),
      ],
    );
  }
}
