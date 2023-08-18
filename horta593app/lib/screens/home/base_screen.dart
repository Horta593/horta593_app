import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horta593app/constants/global_variables.dart';
import 'package:horta593app/screens/tracking/tracking_screen.dart';

import '../../services/profile_service.dart';
import '../homeMenu/bloc/product_bloc.dart';
import '../homeMenu/homemenu_screen.dart';
import '../cart/cart_screen.dart';
import '../profile/profile_screen.dart';

final GlobalKey<_BaseScreenState> firstScreenKey = GlobalKey();

class BaseScreen extends StatefulWidget {
  final Function(int)? onScreenChange;
  static const String routeName = 'base-screen/';
  const BaseScreen({Key? key, this.onScreenChange}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int selectIndex = 0;
  String currentNameLocation = '-';
  static final List<Widget> widgetOptions = <Widget>[
    const MenuScreen(),
    const CartScreen(),
    TrackingScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  _getLocation() async {
    final location = await ProfileService.getMeLocation();
    if (location.exists()) {
      setState(() {
        currentNameLocation = location.address;
      });
    }
  }

  void changeValue(String newAdress) {
    setState(() {
      currentNameLocation = newAdress;
    });
  }

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
          children: [
            Text(
              currentNameLocation,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  fontFamily: "Lato"),
            ),
            const Text(
              "You are Here",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  fontFamily: "Lato"),
            )
          ],
        ),
        centerTitle: false,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ProductBloc>(
            create: (context) => ProductBloc(),
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
                icon: Icon(Icons.payment), label: "Payment"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: "Perfil")
          ]),
    );
  }
}
