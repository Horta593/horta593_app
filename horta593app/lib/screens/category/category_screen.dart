import 'package:flutter/widgets.dart';
import 'package:horta593app/constants/global_variables.dart';
import 'package:horta593app/constants/utils/app_layout.dart';

// ignore: must_be_immutable
class CategoryScreen extends StatelessWidget {
  final String title;
  final String? url;
  final VoidCallback onPress;

  const CategoryScreen(
      {Key? key, required this.title, this.url, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getSize(context);

    return GestureDetector(
        onTap: onPress,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
          child: Container(
              height: 100,
              width: size.width * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: GlobalVariables.darkHorta2,
              ),
              child: (url != null)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(url!),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: GlobalVariables.whiteletter),
                        )
                      ],
                    )
                  : Align(
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: GlobalVariables.whitebackgound),
                      ),
                    )),
        ));
  }
}
