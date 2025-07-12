//ios görünümü paketi
//import 'package:flutter/cupertino.dart';
import 'package:android_studio_projelerim/models/student.dart';
import 'package:android_studio_projelerim/screens/student_add.dart';
import 'package:android_studio_projelerim/screens/student_edit.dart';
//android görünümü paketi
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  // _MyAppState' i return ediyor arrow function ile
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String mesaj = "KOU Öğrenci Bilgi Sistemi";

  String sinavSonucuMesaji = "";

  // bu, tanımlama çokça kullanılan bir taktik. Bu sayede hiçbir sayfada bana hata vermiyor.
  Student selectedStudent = Student.withId(0, "", "", 0);

  // generic list bu şekil yazılıyor.
  List<Student> students = [
    Student.withId(1,"Osman", "Gündoğdu", 87),
    Student.withId(2,"Ferhat", "Feyzullah", 40),
    Student.withId(3,"Ömer", "Pekdemir", 45),
    Student.withId(4,"Ahmet Fikret", "Özsaraç", 100),
    Student.withId(5,"Emirhan", "Taşcı", 70),
    Student.withId(6,"Sezer", "Ahmet", 80)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mesaj),
        backgroundColor: Colors.grey,
        foregroundColor: Colors.black,
      ),
      body: buildBody(context),
    );
  }

  void mesajGoster(BuildContext context, String sinavSonucuMesaji) {
    var alert = AlertDialog(
      title: Text("İşlem Sonucu"),
      content: Text(sinavSonucuMesaji),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: students.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(students[index].profilePic),
                ),
                title: Text(students[index].getFirstName + " " + students[index].lastName),
                subtitle: Text("Sınavdan aldığı not: " + students[index].mark.toString() + " [" + students[index].getStatus + "]"),
                trailing: buildStatusIcon(students[index].mark),
                onTap: () {
                  setState(() {
                    selectedStudent = students[index];
                  });
                  print(selectedStudent.firstName);
                }
              );
            }
          )
        ),
        Text("Seçili Öğrenci: " + selectedStudent.firstName),
        Row(children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 4,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.green),
              child: Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 5.0,),
                  Text("Yeni öğrenci"),
                ],
              ),
              onPressed:  () async {
                await Navigator.push(context, MaterialPageRoute(builder: (context) => StudentAdd(students)));
                setState(() {
                  
                });
              },
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: ElevatedButton(
              child: Row(
                children: [
                  Icon(Icons.update),
                  SizedBox(width: 5.0,),
                  Text("Güncelle"),
                ],
              ),
              style: ElevatedButton.styleFrom(
                  textStyle:
                      TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.yellowAccent),
              onPressed: () async {
                await Navigator.push(context, MaterialPageRoute(builder: (context) => StudentEdit(selectedStudent)));
                setState(() {
                  
                });
              },
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: ElevatedButton(
              child: Row(
                children: [
                  Icon(Icons.delete),
                  SizedBox(width: 5.0,),
                  Text("Sil"),
                ],
              ),
              style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.redAccent),
              onPressed: () {
                setState(() {
                  students.remove(selectedStudent);
                });
                var mesaj = "Seçili Kayıt Silindi.";
                mesajGoster(context, mesaj);
              },
            ),
          ),
        ]),
      ],
    );
  }

  Widget buildStatusIcon(int mark) {
    var kategori =
        mark >= 90 ? 'A' : (mark >= 80 ? 'B' : (mark >= 50 ? 'C' : 'D'));
    switch (kategori) {
      case 'A':
        return Icon(Icons.done_outline_rounded);
      case 'B':
        return Icon(Icons.done_outline_rounded);
      case 'C':
        return Icon(Icons.done_outline_rounded);
      case 'D':
        return Icon(Icons.clear_outlined);
      default:
        sinavSonucuMesaji = "Geçerli bir değer girilmedi.";
    }
    return Icon(Icons.access_time_filled);
  }
}
