mixin StudentValidationMixin{
  String? validateFirstName(String value){
    if(value.length < 2){
      return "İsim en az 2 karakter olmalıdır.";
    }
  }
  String? validateLastName(String value){
    if(value.length < 2){
      return "Soyisim en az 2 karakter olmalıdır.";
    }
  }
  String? validateMark(String value){
    var mark = int.parse(value);
    if(mark < 0 || mark > 100){
      return "Not 0-100 arasında olmalıdır.";
    }
  }
}