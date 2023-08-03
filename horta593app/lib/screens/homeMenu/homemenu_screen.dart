import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horta593app/constants/utils/app_layout.dart';
import 'package:horta593app/screens/category/category_screen.dart';

import '../../constants/global_variables.dart';
import '../../model/product_model.dart';
import '../../widgets/counter_custom.dart';
import '../../widgets/text_normal.dart';
import '../../widgets/text_title.dart';
import 'bloc/product_bloc.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int c = 0;
  List<Product> _listItems = [];
  TextEditingController _textController = TextEditingController();
  List<Product> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _listItems;
  }

  void _filterItems(value) {
    setState(() {
      _filteredItems = _listItems
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void _showBottomSheet(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.network(
                    product.imageurl,
                    width: AppLayout.getSize(context).width * 0.9,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 20, left: 10),
                          child: TitleCustom(title: product.name)),
                      Padding(
                          padding: const EdgeInsets.only(top: 5, left: 10),
                          child: NormalText(
                            text: "\$${product.price}",
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, bottom: 10),
                          child: NormalText(text: product.description)),
                      Container(
                        width: AppLayout.getSize(context).width * 0.9,
                        height:
                            0.5, // Set the desired height to control the length of the divider
                        color: GlobalVariables
                            .greyHorta, // Set the color of the divider line
                      ),
                    ],
                  ),
                ),
                CustomCounterWidget(
                  counterValue: c,
                  onValueChanged: (newValue) {
                    setState(() {
                      c = newValue;
                    });
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductCard(Product product) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SizedBox(
            height: 150,
            child: GestureDetector(
              onTap: () {
                _showBottomSheet(context, product);
              },
              child: Card(
                color: GlobalVariables.darkHorta2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 16),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0),
                      ),
                      child: Image.network(product.imageurl, height: 90),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: TitleCustom(title: product.name)),
                          Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: NormalText(
                                text: "\$${product.price}",
                              )),
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: NormalText(text: product.description))
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      if (state is ProductInitial) {
        return const CircularProgressIndicator(
          color: Colors.amberAccent,
        );
      }
      if (state is ProductLoaded) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: GlobalVariables.background2,
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: GlobalVariables.whiteletter,
                          ),
                          hintText: 'Buscar comida deliciosa...',
                          hintStyle: TextStyle(
                              color: GlobalVariables.whiteletter,
                              fontSize: 14)),
                      onChanged: (value) {
                        _filterItems(value);
                      },
                    )),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: const [
                      CategoryScreen(title: 'Sandwichs'),
                      CategoryScreen(title: 'Tortillas'),
                      CategoryScreen(title: 'Ensaldas'),
                      CategoryScreen(title: 'Promos'),
                      CategoryScreen(title: 'Bebidas'),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: 140,
                        width: AppLayout.getSize(context).width,
                        child: PageView(children: [
                          Container(
                            color: Colors.black,
                          ),
                          Container(
                            color: Colors.blue,
                          ),
                          Container(
                            color: Colors.amber,
                          )
                        ]),
                      ),
                    )),
                if (_filteredItems.isNotEmpty)
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) =>
                          _buildProductCard(_filteredItems[index]))
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      Widget wg = _buildProductCard(Product.getMenu()[index]);
                      _listItems = Product.getMenu();
                      return wg;
                    },
                    itemCount: Product.getMenu().length,
                  ),
              ],
            ),
          ),
        );
      } else {
        return const Text("Ups! Something went wrong!");
      }
    });
  }
}
