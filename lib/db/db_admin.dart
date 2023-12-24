import 'dart:io';

import 'package:flutter_sqf_lite/models/book_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBAdmin {
  // Crearemos el patron usando singleton
  Database? myDatabase;
  static final DBAdmin db = DBAdmin._();
  DBAdmin._();

  Future<Database?> getChechkDataBase() async {
    if (myDatabase != null) return myDatabase;
    myDatabase = await initDB();
    return myDatabase;
  }

  // Gestionamos la ruta de la bd, creamos la tabla
  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "BookDb.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int v) async {
      await db.execute(
          "CREATE TABLE BOOK(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, author TEXT, description TEXT, image TEXT)");
    });
  }

  Future<List> getBooksRaw() async {
    final Database? db = await getChechkDataBase();
    List response = await db!.rawQuery("SELECT * FROM BOOK");
    return response;
  }

  Future<List<BookModel>> getBooks() async {
    List<BookModel> books = [];
    final Database? db = await getChechkDataBase();
    List response = await db!.query("BOOK", orderBy: "id DESC");
    books = response.map<BookModel>((e) => BookModel.fromJson(e)).toList();
    return books;
  }

  // Create - Insertar data dentro de la tabla
  Future<int> insertBookRaw(BookModel model) async {
    final Database? db = await getChechkDataBase();
    int resp = await db!.rawInsert(
        "INSERT INTO BOOK (title, author, description, image) VALUES ('${model.title}', '${model.author}', '${model.description}', '${model.image}')");
    return resp;
  }

  Future<int> insertBook(BookModel model) async {
    final Database? db = await getChechkDataBase();
    int res = await db!.insert("BOOK", model.toJson());
    return res;
  }
}
