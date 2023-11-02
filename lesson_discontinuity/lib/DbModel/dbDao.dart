


import 'package:lesson_discontinuity/DbModel/dbHelper.dart';
import 'package:lesson_discontinuity/Lessons.dart';

class dbDao{
  Future<List<Lessons>> allLesson() async{
    var db  = await dbHelper.dbAccess();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM dersler");
    return List.generate(maps.length, (i){
      var row = maps[i];
      return Lessons(row["ders_id"], row["ders_ad"], row["ders_devamsizlik"]);
    });
  }

  Future<void> addLesson(String lessonCode,int lessonDiscontinuity) async{
    var db = await dbHelper.dbAccess();

    var information = Map<String,dynamic>();
    information["ders_ad"] = lessonCode; //db deki ders_ad kısmına kayıt ettim
    information["ders_devamsizlik"] = lessonDiscontinuity;
    await db.insert("dersler", information);
  }


  Future<void> removeLesson(int lesson_id) async{
    var db = await dbHelper.dbAccess();
    await db.delete("dersler",where: "ders_id=?" ,whereArgs: [lesson_id]);
  }

  Future<void> updateLesson(int lessonId,String lessonCode,int lessonDiscontinuity) async{
    var db = await dbHelper.dbAccess();

    var information = Map<String,dynamic>();
    information["ders_ad"] = lessonCode;
    information["ders_devamsizlik"] = lessonDiscontinuity;
    await db.update("dersler", information ,where: "ders_id=?",whereArgs: [lessonId]);
  }
}