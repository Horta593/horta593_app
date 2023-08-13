import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Category extends Equatable {
  String id;
  String icon;
  String name;

  Category({required this.id, required this.icon, required this.name});

  @override
  List<Object?> get props => [id, icon, name];

  factory Category.fromJson(Map<String, dynamic> json) {
    Category item =
        Category(id: json['id'], name: json['name'], icon: json['icon']);
    return item;
  }

  String toJson() {
    return jsonEncode(
      {'name': name, 'id': id, 'icon': icon},
    );
  }
}
