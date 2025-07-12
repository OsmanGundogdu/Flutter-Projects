import 'package:android_studio_projelerim/models/student.dart';
import 'package:android_studio_projelerim/validation/student_validator.dart';
import 'package:flutter/material.dart';

class StudentEdit extends StatefulWidget{
  Student? selectedStudent;
  StudentEdit(Student selectedStudent){
    this.selectedStudent = selectedStudent;
  }
  @override
  State<StatefulWidget> createState() {
    return _StudentEditState(selectedStudent);
  }

}

class _StudentEditState extends State with StudentValidationMixin{
  Student? selectedStudent;
  var formKey = GlobalKey<FormState>();
  _StudentEditState(Student? selectedStudent){
    this.selectedStudent = selectedStudent;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Güncelleme: " + selectedStudent!.firstName + " " + selectedStudent!.lastName),
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
      initialValue: selectedStudent!.firstName,
      decoration: InputDecoration(labelText: "Öğrenci Adı", hintText: selectedStudent!.firstName),
      validator: (value) => validateFirstName(value.toString()),
      onSaved: (value) {
        if (value != null) {
          selectedStudent!.firstName = value;
        }
      },
    );
  }
  
  Widget buildLastNameField() {
    return TextFormField(
      initialValue: selectedStudent!.lastName,
      decoration: InputDecoration(labelText: "Öğrenci Soyadı", hintText: selectedStudent!.lastName),
      validator: (value) => validateLastName(value.toString()),
      onSaved: (value) {
        if (value != null) {
          selectedStudent!.lastName = value;
        }
      },
    );
  }
  
  Widget buildMarkField() {
    return TextFormField(
      initialValue: selectedStudent!.mark.toString(),
      decoration: InputDecoration(labelText: "Öğrenci Puanı", hintText: selectedStudent!.mark.toString()),
      validator: (value) => validateMark(value.toString()),
      onSaved: (value) {
        if (value != null) {
          selectedStudent!.mark = int.parse(value);
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
            saveStudent();
            Navigator.pop(context);
          }
        },
      ),
    );
  }
  
  void saveStudent() {
    print(selectedStudent!.firstName + " " + selectedStudent!.lastName + " " + selectedStudent!.mark.toString() + " güncellendi.");
  }
  
}