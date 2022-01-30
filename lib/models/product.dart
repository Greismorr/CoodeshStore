import 'package:coodesh_store/models/mixins/have_date.dart';

class Product with HaveDate {
  String id;
  String title;
  String description;
  String? picture;
  double price;
  int rating;
  String type;
  dynamic createdAt;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.picture,
    required this.price,
    required this.rating,
    required this.type,
    this.createdAt,
  });

  factory Product.fromJson(
    Map<String, dynamic> json,
  ) {
    Product product = Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      picture: json['picture'],

      //O toDouble é necessário porque o Firebase interpreta doubles terminados
      //em .0 como int
      price: json['price'].toDouble(),
      rating: json['rating'],
      type: json['type'],
      createdAt: json['created_at'],
    );

    return product;
  }

  factory Product.fromAssetJson({
    required Map<String, dynamic> json,
    required String id,
    required Map<String, String> createdAt,
  }) {
    Product product = Product(
      id: id,
      title: json['title'],
      description: json['description'],
      picture: json['picture'],
      price: json['price'],
      rating: json['rating'],
      type: json['type'],
      createdAt: createdAt,
    );

    return product;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> product = new Map<String, dynamic>();
    product['id'] = this.id;
    product['title'] = this.title;
    product['description'] = this.description;
    product['picture'] = this.picture;
    product['price'] = this.price;
    product['rating'] = this.rating;
    product['type'] = this.type;
    product['created_at'] = this.createdAt;
    return product;
  }
}
