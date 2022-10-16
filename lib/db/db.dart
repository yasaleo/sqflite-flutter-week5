import 'package:demo/db/dbmodel.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  DatabaseHelper._privateconstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateconstructor();

  static Database? _database;
  Future<Database> get databse async => _database ??= await _initdatabse();

  Future<Database> _initdatabse() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'students.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _oncreate,
    );
  }

  Future _oncreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE students(
    id INTEGER PRIMARY KEY,
    name TEXT,
    image TEXT,
    age   INTEGER,
    mobile INTEGER,
    address TEXT
  )
''');
  }



  Future<List<Student>> getStudent() async {
    Database db = await instance.databse;
    var students = await db.query('students', orderBy: 'name');

    List<Student> studenList = students.isNotEmpty
        ? students.map((e) => Student.fromMap(e)).toList()
        : [];
    return studenList;
  }



  Future<int> add(Student student) async {
    Database db = await instance.databse;
    return await db.insert('students', student.toMap());
  }

  Future<int> update(Student student) async {
    Database db = await instance.databse;
    return await db.update('students', student.toMap(),
        where: "id = ?", whereArgs: [student.id]);
  }

  Future<int> remove(int id) async {
    Database db = await instance.databse;
    return await db.delete('students', where: 'id=?', whereArgs: [id]);
  }
}
