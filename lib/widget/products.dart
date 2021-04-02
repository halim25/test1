import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
  });
}

class Products with ChangeNotifier {
  List<Product> productsList = [];

  void add(
      {String id,
      String title,
      String description,
      double price,
      String imageUrl}) {
    productsList.add(Product(
      id: id,
      title: title,
      description: description,
      price: price,
      imageUrl: imageUrl,
    ));

    print(imageUrl);

    notifyListeners();
  }

  void delete(String id) {
    productsList.removeWhere((element) => element.id == id);
    notifyListeners();
    print("Item Deleted");
  }
}
