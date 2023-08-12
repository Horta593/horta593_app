import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horta593app/constants/global_variables.dart';

import '../homeMenu/bloc/product_bloc.dart';
import '../homeMenu/homemenu_screen.dart';
import '../cart/bloc/cart_bloc.dart';
import '../cart/cart_screen.dart';
import '../profile/profile_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int selectIndex = 0;
  static final List<Widget> widgetOptions = <Widget>[
    const MenuScreen(),
    const CartScreen(),
    const Text("Premios"),
    const ProfileScreen(),
  ];
  void _onItemsTapped(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        backgroundColor: GlobalVariables.primarybackground,
        leading: const Icon(
          Icons.place_outlined,
          color: GlobalVariables.secondaryColor,
          size: 40.0,
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Casa",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  fontFamily: "Lato"),
            ),
            Text(
              "Av. Francisco de Orellana 562",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  fontFamily: "Lato"),
            )
          ],
        ),
        centerTitle: false,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProductBloc()..add(LoadProduct()),
          ),
          BlocProvider<CartBloc>(
            create: (BuildContext context) => CartBloc(),
          ),
        ],
        child: widgetOptions[selectIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectIndex,
          onTap: _onItemsTapped,
          elevation: 10,
          selectedItemColor: GlobalVariables.secondaryColor,
          unselectedItemColor: GlobalVariables.greyHorta,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: "Carrito"),
            BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard_outlined), label: "Premios"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: "Perfil")
          ]),
    );
  }
}
