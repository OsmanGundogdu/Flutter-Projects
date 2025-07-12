import 'package:android_studio_projelerim/models/student.dart';
import 'package:android_studio_projelerim/validation/student_validator.dart';
import 'package:flutter/material.dart';

class StudentAdd extends StatefulWidget{
  List<Student>? students;
  StudentAdd(List<Student> students){
    this.students = students;
  }
  @override
  State<StatefulWidget> createState() {
    return _StudentAddState(students);
  }

}

class _StudentAddState extends State with StudentValidationMixin{
  List<Student>? students;
  var student = Student.withoutInfo();
  var formKey = GlobalKey<FormState>();
  _StudentAddState(List<Student>? students){
    this.students = students;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Öğrenci Ekle"),
        backgroundColor: Colors.grey,
        foregroundColor: Colors.black,
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              buildFirstNameField(),
              buildLastNameField(),
              buildMarkField(),
              buildSubmitButton()
            ],
          ),
        ),
      )
    );
  }

  Widget buildFirstNameField(){
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci Adı", hintText: "Osman"),
      validator: (value) => validateFirstName(value.toString()),
      onSaved: (value) {
        if (value != null) {
          student.firstName = value;
        }
      },
    );
  }
  
  Widget buildLastNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci Soyadı", hintText: "Gündoğdu"),
      validator: (value) => validateLastName(value.toString()),
      onSaved: (value) {
        if (value != null) {
          student.lastName = value;
        }
      },
    );
  }
  
  Widget buildMarkField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci Puanı", hintText: "87"),
      validator: (value) => validateMark(value.toString()),
      onSaved: (value) {
        if (value != null) {
          student.mark = int.parse(value);
        }
      },
    );
  }
  
  Widget buildSubmitButton() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.greenAccent),   
        child: Text("Kaydet"),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            students!.add(student);
            saveStudent();
            Navigator.pop(context);
          }
        },
      ),
    );
  }
  
  void saveStudent() {
    print(student.firstName + " " + student.lastName + " " + student.mark.toString() + " eklendi.");
  }
  
}