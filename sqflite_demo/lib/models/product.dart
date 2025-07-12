class Product {
  int? id ;
  String name = '';
  String description = '';
  double unitPrice = 0.0;

  // Product(String name, String description, double unitPrice) {
  //   this.name = name;
  //   this.description = description;
  //   this.unitPrice = unitPrice;
  // }
  // aşağıdakiler aynı yukarıdaki gibi oluşturulan bir constructordır. sadece bu şekilde yazımı daha kısa ve okunabilir olur.
  Product({required this.name, required this.description, required this.unitPrice});
  Product.withId({required this.id, required this.name, required this.description, required this.unitPrice});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map ["name"] = name;
    map ["description"] = description;
    map ["unitPrice"] = unitPrice;
    map ["id"] = id;
    return map;
  }

  // Aşağıdaki kullanım şekli de yukarıdaki ile aynıdır. Sadece bu şekilde yazımı daha kısa ve okunabilir olur. Ayrıca bu kullanım daha günceldir.
  // Map<String, dynamic> toMap() {
  //   return {
  //     "name": name,
  //     "description": description,
  //     "unitPrice": unitPrice,
  //     if (id != null) "id": id,
  //   };
  // }

  Product.fromObject(dynamic o){
    this.id = int.tryParse(o["id"].toString())!;
    this.name = o["name"];
    this.description = o["description"];
    this.unitPrice = double.tryParse(o["unitPrice"].toString())!;
  }
}