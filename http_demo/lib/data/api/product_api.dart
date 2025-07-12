// burada as http diyince aşağıdaki kodda http diyerek kullanabileceğiz. buna alyans denir.
import 'package:http/http.dart' as http;

class ProductApi {
  static Future getProducts() {
    // aşağıda localhost yerine 10.0.0.2 yazdım çünkü emülatörün localhostunu kullanmamız gerekiyor.
    // bağlı olduğun internet ağından dolayı bilgisayarın ip adresi değişebilir.
    return http.get(Uri.parse("http://192.168.146.164:3000/products"));
  }

  static Future getProductsByCategoryId(int categoryId) {
    return http.get(Uri.parse(
        "http://192.168.146.164:3000/products?categoryId=$categoryId"));
  }
}
