import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horta593app/screens/profile/bloc/profile_bloc.dart';
import 'package:horta593app/widgets/custom_button.dart';

import '../../constants/global_variables.dart';
import '../../constants/utils/app_layout.dart';
import '../../widgets/text_normal.dart';
import '../../widgets/text_title.dart';
import '../login/login_screen.dart';
import '../map/googlemap_screen.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/route-profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileBloc()..add(ProfileRequestEvent()),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: ((context, state) {
            if (state is ProfileInitialState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.amberAccent,
                ),
              );
            }
            if (state is ProfileSuccessfullState) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _title(),
                      _name(state.user.fullName()),
                      _email(state.user.email),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          children: [
                            _miDireccion(context, state),
                            _misOrdenes(context),
                            // _ayuda(context),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CustomButton(
                                  text: "Log out",
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, LoginScreen.routeName);
                                  }),
                            )
                          ],
                        ),
                      )
                    ]),
              );
            }
            return const Center(
              child: Text("Nothing!"),
            );
          }),
        ));
  }

  Widget _title() {
    return const Padding(
      padding: EdgeInsets.only(top: 20),
      child: Text(
        "Perfil",
        style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: GlobalVariables.whiteletter),
      ),
    );
  }

  Widget _email(String email) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        email,
        style:
            const TextStyle(fontSize: 15, color: GlobalVariables.whiteletter),
      ),
    );
  }

  Widget _name(String name) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        name,
        style:
            const TextStyle(fontSize: 18, color: GlobalVariables.whiteletter),
      ),
    );
  }

  Widget _ayuda(BuildContext context) {
    return Row(
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
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: FractionallySizedBox(
                heightFactor: 0.8,
                child: Container(
                    decoration: const BoxDecoration(
                      color: GlobalVariables.primarybackground,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 15, left: 15, right: 15, bottom: 30),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: TitleCustom(
                                    title: "product.name",
                                    sizeT: 18,
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: NormalText(
                                      sizeT: 18,
                                      text: "\$product.price",
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: SizedBox(
                                        height: 90,
                                        child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: NormalText(
                                              text: "product.description",
                                              trunc: false,
                                            )))),
                                Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Container(
                                      width: AppLayout.getSize(context).width *
                                          0.9,
                                      height: 0.5,
                                      color: GlobalVariables.greyHorta,
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ))));
      },
    );
  }

  Widget _misOrdenes(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.document_scanner_rounded,
          color: GlobalVariables.secondaryColor,
          size: 40.0,
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              context.read<ProfileBloc>().add(OrdersRequestEvent());
              BlocListener<ProfileBloc, ProfileState>(
                  listener: (context, state) {
                if (state is OrdersUserSuccessfullState) {
                  _showBottomSheet(context);
                }
              });
            },
            style: // Your style goes here
                TextButton.styleFrom(
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
    );
  }

  Widget _miDireccion(BuildContext context, ProfileSuccessfullState state) {
    return Row(
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
                MaterialPageRoute(builder: (context) => const MapSample()),
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
        ),
      ],
    );
  }
}
