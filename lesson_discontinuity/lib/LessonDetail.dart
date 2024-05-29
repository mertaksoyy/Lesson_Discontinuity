import 'package:flutter/material.dart';
import 'package:lesson_discontinuity/DbModel/dbDao.dart';
import 'package:lesson_discontinuity/data/entity/Lessons.dart';
import 'package:lesson_discontinuity/main.dart';

class LessonDetail extends StatefulWidget {
  const LessonDetail({super.key, required this.lesson});
  final Lessons lesson;
  @override
  State<LessonDetail> createState() => _lessonDetailState();
}

class _lessonDetailState extends State<LessonDetail> {
  int discontinuity = 0;
  TextEditingController tfDetailCode = TextEditingController();
  TextEditingController tfDetailDiscontinuity = TextEditingController();

  Future<void> lessonUpdate(
      int lessonId, String lessonCode, int lessonDiscontinuity) async {
    await dbDao().updateLesson(lessonId, lessonCode, lessonDiscontinuity);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  void initState() {
    super.initState();

    var lesson = widget.lesson;
    tfDetailCode.text = lesson.ders_ad;
    tfDetailDiscontinuity.text = lesson.ders_devamsizlik.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lesson Update"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tfDetailCode,
                decoration: const InputDecoration(
                  labelText: "Enter Lesson Code",
                ),
              ),
              TextField(
                controller: tfDetailDiscontinuity,
                decoration: const InputDecoration(
                  labelText: "Enter Discontinuity",
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.update),
        label: const Text("Update"),
        tooltip: "Update",
        onPressed: () {
          discontinuity = int.parse(tfDetailDiscontinuity.text);
          lessonUpdate(widget.lesson.ders_id, tfDetailCode.text, discontinuity);
        },
      ),
    );
  }
}
