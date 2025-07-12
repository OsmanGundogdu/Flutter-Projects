import 'package:bloc_sample/models/product.dart';

class ProductService {
  static List<Product> products = [];

  static ProductService _singleton = ProductService._internal();

  factory ProductService() {
    return _singleton;
  }

  ProductService._internal();

  static List<Product> getAll() {
    products.add(new Product(1, "Hp Laptop", 28000));
    products.add(new Product(2, "Asus Laptop", 30000));
    products.add(new Product(3, "Acer Laptop", 35000));
    return products;
  }
}
