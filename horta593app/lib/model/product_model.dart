import 'dart:convert';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Product extends Equatable {
  String id;
  String image;
  String name;
  String description;
  String price;
  String category;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.image,
      required this.category});

  @override
  List<Object?> get props => [name, description, price, image, category];

  factory Product.fromJson(Map<String, dynamic> json) {
    Product item = Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      category: json['categoryId'],
    );
    return item;
  }

  String toJson() {
    return jsonEncode(
      {
        'name': name,
        'description': description,
        'image': image,
        'price': price,
        'category': category
      },
    );
  }
}
