import 'package:flutter/material.dart';
import 'package:http_demo/models/product.dart';

class ProductListRowWidget extends StatelessWidget {
  final Product product;
  const ProductListRowWidget(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return buildProductItemCard(context);
  }

  Widget buildProductItemCard(BuildContext context) {
    return InkWell(
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
                child: Image.network(
                    "https://cdn.pixabay.com/photo/2015/12/09/17/11/vegetables-1085063_960_720.jpg"),
                height: 130.0,
                width: MediaQuery.of(context).size.width / 2),
            Text(product.productName!),
            Text(
              product.unitPrice.toString() + " TL",
              style: TextStyle(fontSize: 15.0, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
