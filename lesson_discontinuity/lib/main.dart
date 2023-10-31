import 'package:flutter/material.dart';
import 'package:lesson_discontinuity/DbModel/dbDao.dart';
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


  /*void dersEklePopup() {
    var lessonController = TextEditingController();
    //bool errorMessage = false;
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Ders Ekle"),
        content: SingleChildScrollView(
            child:
            TextField(
              controller: lessonController,
              decoration: InputDecoration(
                //errorText: (errorMessage) ? "Can't Empty" : null,
                labelText: "Ders Kodu Giriniz",
              ),
            )
        ),
        actions: [
          ElevatedButton(
            child: const Text("Ders Ekle"),
            onPressed: () {
              addLesson(lessonController.toString());
              Navigator.pop(context);
              print("okundu");
              /*if(lessonController.text.isEmpty){
                setState(() => errorMessage = true);
              }
              else{
                setState(() {
                });
              }

               */
            },
          ),
          ElevatedButton(
            child: const Text("İptal"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
    }
    );
  }
   */


  Future<List<Lessons>> getAll() async{
    var lessonList = await dbDao().allLesson();
    return lessonList;
  }

  Future<void> delete(int lesson_id) async{
    await dbDao().removeLesson(lesson_id);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Devamsızlık Takip Uygulaması"),
      ),
      body:FutureBuilder<List<Lessons>>(
        future: getAll(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var getList = snapshot.data;
            return ListView.builder(
                itemCount: getList!.length,
                itemBuilder: (context,indeks){
                  var list = getList[indeks];
                  return Card(
                    child: SizedBox(height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(list.ders_id.toString()),
                          Text(list.ders_ad,style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(list.ders_devamsizlik.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                          ElevatedButton(
                            child: const Icon(Icons.add),
                            onPressed: (){
                              setState(() {
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  );
                }
            );
          }else{
            return const Center();
          }
        },
      ),
      floatingActionButton:FloatingActionButton(
        child:Icon(Icons.add),
        tooltip: "Ekle",
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddLesson()));
          //dersEklePopup();
        },
      ),
    );
  }
}

