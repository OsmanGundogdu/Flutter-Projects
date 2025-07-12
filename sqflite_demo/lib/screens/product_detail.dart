import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/product.dart';

class ProductDetail extends StatefulWidget {
  late Product product;
  ProductDetail(this.product);
  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }

}

enum Options {delete, update}

class _ProductDetailState extends State{
  late Product product;
  _ProductDetailState(this.product);
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();

  @override
  void initState() {
    txtName.text = product.name;
    txtDescription.text = product.description;
    txtUnitPrice.text = product.unitPrice.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Detayı : ${product.name}"),
        actions: <Widget>[
          PopupMenuButton <Options>(
            onSelected: selectProcess,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              PopupMenuItem <Options>(
                value: Options.delete,
                child: Text("Sil"),
              ),
              PopupMenuItem <Options>(
                value: Options.update,
                child: Text("Güncelle"),
              )
            ]
            )
        ],
      ),
      body: buildProductDetail(),
    );
  }
  
  buildProductDetail() {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget> [
          buildNameField(),
          buildDescriptionField(),
          buildUnitPriceField()
        ],
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
  
  void selectProcess(Options value) async {
    switch(value){
      case Options.delete:
        await dbHelper.delete(product);
        Navigator.pop(context,true);
        break;
      case Options.update:
        // await dbHelper.update(Product.withId(id:product.id, name: txtName.text, description: txtDescription.text, unitPrice: double.tryParse(txtUnitPrice.text) ?? 0.0)); aşağıdaki ile aynı işlevi görüyor.
        await dbHelper.update(Product.withId(id:product.id, name: txtName.text, description: txtDescription.text, unitPrice: double.tryParse(txtUnitPrice.text)!));
        Navigator.pop(context, true);
        break;
      default:
    }
  }

}