import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horta593app/constants/utils/app_layout.dart';
import 'package:horta593app/model/category_model.dart';
import 'package:horta593app/screens/category/bloc/categories_bloc.dart';
import 'package:horta593app/screens/category/category_screen.dart';

import '../../constants/global_variables.dart';
import '../../model/product_model.dart';
import '../../widgets/counter_custom.dart';
import '../../widgets/text_normal.dart';
import '../../widgets/text_title.dart';
import 'bloc/product_bloc.dart';

class MenuScreen extends StatefulWidget {
  static const String routeName = 'menu-screen/';
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<Product> _listItems = [];
  TextEditingController _textController = TextEditingController();
  List<Product> _filteredItems = [];
  List<Product> _filteredItemsCategory = [];

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

  void _filterItemsCategory(productofCategoryList) {
    setState(() {
      _filteredItemsCategory = productofCategoryList;
    });
  }

  void _showBottomSheet(BuildContext context, Product product) {
    int _counter = 0;

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
                    product.image,
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
                        height: 0.5,
                        color: GlobalVariables.greyHorta,
                      ),
                    ],
                  ),
                ),
                CustomCounterWidget(
                  counterValue: _counter,
                  onValueChanged: (newValue) {
                    setState(() {
                      _counter = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildProductCard(Product product) {
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
                      child: Image.network(
                        product.image,
                        height: 90,
                        scale: 1.0,
                      ),
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
    return BlocProvider(
      create: (context) => ProductBloc()..add(ProductRequestEvent()),
      child: BlocBuilder<ProductBloc, ProductState>(builder: ((context, state) {
        if (state is ProductLoadedState) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.amberAccent,
            ),
          );
        }
        if (state is ProductSuccessState) {
          return _bodyMenu(context, state);
        }
        return const Center(
          child: Text("Nothing!"),
        );
      })),
    );
  }

  Widget _bodyMenu(BuildContext context, ProductSuccessState state) {
    List<Product> productList = state.products;
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
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: GlobalVariables.whiteletter,
                      ),
                      hintText: 'Buscar comida deliciosa...',
                      hintStyle: TextStyle(
                          color: GlobalVariables.whiteletter, fontSize: 14)),
                  onChanged: (value) {
                    _filterItems(value);
                  },
                )),
            _textController.text.isEmpty
                ? _filteredItemsCategory.isNotEmpty
                    ? Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _filteredItemsCategory.clear();
                                      });
                                    },
                                    child: const Icon(Icons.arrow_back),
                                  ))),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _filteredItemsCategory.length,
                              itemBuilder: (context, index) => buildProductCard(
                                  _filteredItemsCategory[index]))
                        ],
                      )
                    : Column(
                        children: [
                          _categories(context),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 140,
                                  width: AppLayout.getSize(context).width,
                                  child: PageView(children: [
                                    Container(
                                      color: Colors.amber,
                                    ),
                                    Container(
                                      color: Colors.black,
                                    ),
                                    Container(
                                      color: Colors.blue,
                                    ),
                                  ]),
                                ),
                              )),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              Widget wg = buildProductCard(productList[index]);
                              _listItems = productList;
                              return wg;
                            },
                            itemCount: productList.length,
                          ),
                        ],
                      )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) =>
                        buildProductCard(_filteredItems[index]))
          ],
        ),
      ),
    );
  }

  Widget _categories(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 20),
      child: BlocProvider(
        create: (context) => CategoriesBloc()..add(CategoryRequestEvent()),
        child: BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: ((context, state) {
          if (state is CategoryLoadedState) {
            return const Center(
              child: CircularProgressIndicator(
                color: GlobalVariables.greenHorta,
              ),
            );
          }
          if (state is CategoriesProductsSuccessState) {
            List<Category> categoryList = state.categories;
            return Row(
              children: [
                ...categoryList
                    .map((item) => CategoryScreen(
                          title: item.name.toUpperCase(),
                          url: item.icon,
                          onPress: () {
                            _filterItemsCategory(
                                state.productsCategories[item.id]);
                          },
                        ))
                    .toList(),
              ],
            );
          }
          return const Center(
            child: Text("Nothing!"),
          );
        })),
      ),
      //   Row(
      // children: [
      //   CategoryScreen(
      //       title: 'Sandwichs',
      //       onPress: () {
      //         _filterItemsCategory('Sandwichs');
      //       }),
      //   CategoryScreen(
      //       title: 'Tortillas',
      //       onPress: () {
      //         _filterItemsCategory('Tortillas');
      //       }),
      //   CategoryScreen(
      //       title: 'Ensaldas',
      //       onPress: () {
      //         _filterItemsCategory('Ensaladas');
      //       }),
      //   CategoryScreen(
      //       title: 'Promos',
      //       onPress: () {
      //         _filterItemsCategory('Promos');
      //       }),
      //   CategoryScreen(
      //       title: 'Bebidas',
      //       onPress: () {
      //         _filterItemsCategory('Bebidas');
      //       }),
      // ],
      // ),
    );
  }

  // Widget _bodyCategories(BuildContext context, List<Category> categoryList) {
  //   return BlocBuilder<CategoriesBloc, CategoriesState>(
  //       builder: (context, state) {
  //     return Row(
  //       children: categoryList
  //           .map((item) => CategoryScreen(
  //                 title: item.name.toUpperCase(),
  //                 url: item.icon,
  //                 onPress: () async {
  //                   final bloc = CategoriesBloc();
  //                   bloc.add(CategoriesProductsRequestEvent(item.id));
  //                   final state = await bloc.stream
  //                       .firstWhere((s) => s is CategoryProductSuccessState);

  //                   if (state is CategoryProductSuccessState) {
  //                     setState(() {
  //                       _filteredItemsCategory = state.categoriesproducts;
  //                     });
  //                   }
  //                   // Optionally navigate to a new screen here or show a modal with the products
  //                 },
  //               ))
  //           .toList(),
  //     );
  //   });
  // }
}
