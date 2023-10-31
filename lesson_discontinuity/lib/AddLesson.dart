import 'package:flutter/material.dart';
import 'package:lesson_discontinuity/DbModel/dbDao.dart';
import 'package:lesson_discontinuity/main.dart';

class AddLesson extends StatefulWidget {
  const AddLesson({super.key});
  @override
  State<AddLesson> createState() => _AddLessonState();
}

class _AddLessonState extends State<AddLesson> {
  int discontinuity = 0;
  TextEditingController tflessonCode = TextEditingController();
  TextEditingController tflessonDiscontinuity = TextEditingController();

  Future<void> addLesson(String lessonCode,int lessonDiscontinuity) async{
    await dbDao().addLesson(lessonCode,lessonDiscontinuity);
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ders Ekleme"),),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tflessonCode,
                decoration: InputDecoration(labelText: "Ders Kodu Giriniz",),
              ),
              TextField(
                controller: tflessonDiscontinuity,
                decoration: InputDecoration(labelText: "Ders Devamsızlık Sayısını Girin",),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton:FloatingActionButton(
        child:Icon(Icons.save),
        tooltip: "Kaydet",
        onPressed: (){
          discontinuity = int.parse(tflessonDiscontinuity.text);
          addLesson(tflessonCode.text, discontinuity);
        },
      ),
    );
  }
}
