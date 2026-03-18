import 'package:flutter/material.dart';
import 'package:bonificacion/student.dart';

class StudentScreen extends StatefulWidget{
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen>{
  bool isLoading = false;
  List<Student> students = [];
  String errorMessage = '';
  
  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  Future<void> loadStudents() async{
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final data = await fetchStudents();
      setState(() {
        students = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Hay un error al cargar';
        isLoading = false;
      });
    }
  }

  Future<List<Student>> fetchStudents() async{
    await Future.delayed(Duration(seconds: 2));
    return[
      Student(name: 'Melissa', lastname: 'Foronda', email: 'm@gmail.com', password: 'Meli123'),
    ];
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estudiantes'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody(){
    if(isLoading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if(errorMessage.isNotEmpty){
      return Center(
        child: Text(errorMessage),
      );
    }

    if(students.isEmpty){
      return Center(
        child: Text("No hay estudiante"),
      );
    }

    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index){
        final student = students[index];

        return Center(
          child: Card(
            margin: EdgeInsets.all(20),
            child: Padding(padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(student.name, style: TextStyle(fontSize: 25),),
                  Text(student.email, style: TextStyle(fontSize: 15),),
                  Text(student.password, style: TextStyle(fontSize: 15),),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}