import 'package:flutter/material.dart';

import '../../constants/global_variables.dart';
import '../../widgets/googlemap_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            "Perfil",
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: GlobalVariables.whiteletter),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text(
            "Juanito Alimana",
            style: TextStyle(fontSize: 18, color: GlobalVariables.whiteletter),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text(
            "micg@gamil.com",
            style: TextStyle(fontSize: 15, color: GlobalVariables.whiteletter),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.place_outlined,
                    color: GlobalVariables.secondaryColor,
                    size: 40.0,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MapSample()),
                        );
                      },
                      style: TextButton.styleFrom(
                        alignment: Alignment.centerLeft,
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Mi direccion',
                          style: TextStyle(color: GlobalVariables.whiteletter),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.document_scanner_rounded,
                    color: GlobalVariables.secondaryColor,
                    size: 40.0,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () => {},
                      style: TextButton.styleFrom(
                        alignment: Alignment.centerLeft,
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Mis ordenes',
                          style: TextStyle(color: GlobalVariables.whiteletter),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.help,
                    color: GlobalVariables.yellow,
                    size: 40.0,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () => {},
                      style: TextButton.styleFrom(
                        alignment: Alignment.centerLeft,
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Ayuda',
                          style: TextStyle(color: GlobalVariables.whiteletter),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }
}
