import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:submition/utils/string_const.dart';

class MyDb {
  Future<Database> initDatabase() async {
    Directory directory = await getApplicationCacheDirectory();
    String path = join(directory.path, 'user.db');
    var db = await openDatabase(path, onCreate: (db, version) async {
      await db.execute('''create table user(
      id integer primary key autoincrement ,
      ${NAME} text not null,
      ${EMAIL} text not null,
      ${AGE} integer not null,
      ${CITY} text not null,
      ${PHONE} text not null,
      ${DOB} text not null,
      ${GENDER} text not null,
      ${ISFAVORITE} integer not null default 0,
      ${HOBBIES} text,
      ${PASSWORD} text not null
      )''');
    }, onUpgrade: (db, oldVersion, newVersion) {}, version: 1);
    return db;
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    Database db = await initDatabase();
    return db.rawQuery('select * from user');
  }

  Future<List<Map<String, dynamic>>> getById(int id) async {
    Database db = await initDatabase();
    return db.rawQuery('select * from user where id = $id');
  }

  Future<void> insert(Map<String, dynamic> map) async {
    Database db = await initDatabase();
    await db.insert('user', map);
  }

  Future<void> updateUser(int id, Map<String, dynamic> updatedData) async {
    Database db = await initDatabase();
    await db.update(
      'user',
      updatedData,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> toggleFavorite(int id, int isFavorite) async {
    Database db = await initDatabase();
    await db.update(
      'user',
      {ISFAVORITE: isFavorite},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteUser(int id) async {
    Database db = await initDatabase();
    await db.delete(
      'user',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getFavoriteUser() async {
    Database db = await initDatabase();
    return db.rawQuery('select * from user where $ISFAVORITE = 1');
  }
}
