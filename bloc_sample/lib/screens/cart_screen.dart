import 'package:bloc_sample/blocs/cart_bloc.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sepetim"),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder(
          stream: cartbloc.getStream,
          initialData: cartbloc.getCart(),
          builder: (context, snapshot) {
            return snapshot.data.length > 0
                ? buildCart(snapshot)
                : Center(
                    child: Text("Sepetiniz boş. Hadi biraz alışveriş yapalım!"),
                  );
          }),
    );
  }

  buildCart(AsyncSnapshot snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, index) {
        final cart = snapshot.data;
        return ListTile(
          title: Text(cart[index].product.name),
          subtitle: Text(cart[index].product.price.toString()),
          trailing: IconButton(
              onPressed: () {
                cartbloc.removeFromCart(cart[index]);
              },
              icon: Icon(Icons.remove_shopping_cart_rounded)),
        );
      },
    );
  }
}
