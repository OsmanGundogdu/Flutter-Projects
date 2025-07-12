import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/product.dart';
import 'package:sqflite_demo/screens/product_add.dart';
import 'package:sqflite_demo/screens/product_detail.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State {
  var dbHelper = DbHelper();
  late List<Product> products;
  int productCount = 0;

  @override
  initState() {
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Listesi"),
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.black87,
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){goToProductAdd();},
        child: Icon(Icons.add),
        tooltip: "Yeni ürün ekle",
      ),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
      itemCount: productCount,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.blueGrey,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Text("P"),
            ),
            title: Text(this.products[position].name),
            subtitle: Text(this.products[position].description),
            onTap: (){goToDetail(this.products[position]);},
          )
        );
      }
    );
  }
  
  void goToProductAdd() async {
    bool? result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ProductAdd()));
    if(result == true){
      getProducts();
    }
  }

  void getProducts() async {
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data) {
      setState(() {
        this.products = data;
        productCount = data.length;
      });
    });
  }
  
  void goToDetail(Product product) async {
    bool? result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(product)));
    if (result != null){
      if(result){
        getProducts();
      }
    }
  }
  
}


