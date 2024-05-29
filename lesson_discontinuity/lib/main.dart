import 'package:flutter/material.dart';
import 'package:lesson_discontinuity/DbModel/dbDao.dart';
import 'package:lesson_discontinuity/LessonDetail.dart';
import 'package:lesson_discontinuity/Lessons.dart';
import 'AddLesson.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Lessons>> getAll() async {
    var lessonList = await dbDao().allLesson();
    return lessonList;
  }

  Future<void> delete(int lesson_id) async {
    await dbDao().removeLesson(lesson_id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lesson Discontinuity App"),
      ),
      body: FutureBuilder<List<Lessons>>(
        future: getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var getList = snapshot.data;
            return ListView.builder(
                itemCount: getList!.length,
                itemBuilder: (context, indeks) {
                  var list = getList[indeks];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LessonDetail(
                                    lesson: list,
                                  )));
                    },
                    child: Card(
                      child: SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //Text(list.ders_id.toString()),
                            Text(
                              list.ders_ad,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              list.ders_devamsizlik.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                delete(list.ders_id);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text("Add"),
        tooltip: "Add",
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddLesson()));
        },
      ),
    );
  }
}
