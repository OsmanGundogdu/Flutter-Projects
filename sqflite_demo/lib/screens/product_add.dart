import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/product.dart';

class ProductAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductAddState();
  }
}

class _ProductAddState extends State {
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Ürün Ekle"),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget> [
            buildNameField(),
            buildDescriptionField(),
            buildUnitPriceField(),
            buildSaveButton(),
          ],
        ),
      ),
    );
  }
  
  buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün Adı"),
      controller: txtName,
    );
  }
  
  buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: "Açıklama"),
      controller: txtDescription,
    );
  }
  
  buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(labelText: "Birim Fiyat"),
      controller: txtUnitPrice,
    );
  }
  
  buildSaveButton() {
    return TextButton(
      child: Text("Ekle"),
      onPressed: addProduct,
    );
  }
  
  void addProduct() async {
    var result = await dbHelper.insert(Product(name: txtName.text, description: txtDescription.text, unitPrice: double.tryParse(txtUnitPrice.text) ?? 0.0));
    Navigator.pop(context, true);
  }


}