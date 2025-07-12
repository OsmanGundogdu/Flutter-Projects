// burada as http diyince aşağıdaki kodda http diyerek kullanabileceğiz. buna alyans denir.
// bağlı olduğun internet ağından dolayı bilgisayarın ip adresi değişebilir.
import 'package:http/http.dart' as http;

class CategoryApi {
  static Future getCategories() {
    return http.get(Uri.parse("http://192.168.146.164:3000/categories"));
  }
}
