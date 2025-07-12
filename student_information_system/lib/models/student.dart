class Student{
  int id = 0;
  String firstName = "default deger.";
  String lastName = "default deger.";
  int mark = 0; // default deger
  String _status = "default deger.";
  String profilePic = "default deger.";

  // yukarıda ilk değer vererek yaptığım için hiçbir sıkıntı olmaz.
  // late String firstname;  => kodun devamında değer atamadan kullanırsan kızar.
  // String? firstname; => kodun devamında değer atamadan kullanırsan kızmaz çünkü nullable olabilir demiş oluyoruz.

  // güncelleme işlemi için bunu kullanacağız mesela
  Student.withId (int id, String firstName, String lastName, int mark) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.mark = mark;
    this.profilePic = "https://cdn.pixabay.com/photo/2018/06/27/07/45/student-3500990_960_720.jpg";
  }

  // yeni oluşturma için bunu kullanacağız
  Student (String firstName, String lastName, int mark) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.mark = mark;
    this.profilePic = "https://cdn.pixabay.com/photo/2018/06/27/07/45/student-3500990_960_720.jpg";
  }

  Student.withoutInfo(){

  }

  String get getFirstName{
    return "OGR - " +  this.firstName;
  }

  void set setFirstName(String firstName){
    this.firstName = firstName;
  }

  String get getStatus{
    String result = "";
    var kategori = mark >= 90
        ? 'A'
        : (mark >= 80
        ? 'B'
        : (mark >= 50 ? 'C' : 'D'));
    switch (kategori) {
    case 'A':
      result = "AA Geçti.";
    break;
    case 'B':
      result = "BA Geçti.";
    break;
    case 'C':
      result = "CC geçti.";
    break;
    case 'D':
      result = "FF Kaldı.";
    break;
    default:
      result = "Geçerli bir değer girilmedi.";
    }
    return result;
  }

}