import 'dart:io';
import 'dart:math';

import 'package:contact_buddy_app/models/contact.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  //Configuration Database
  static final _dbName = 'contactBuddy.db';
  static final _dbVersion = 2; //Version 2.0 Feature Update With Image Upload

  //Convert Class to Singleton Class
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;
  Future<Database> get database async {
    //Already created Database
    if (_database != null) return _database!;

    //Create a new Database
    _database = await _initiateDatabase();
    return _database!;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);

    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${Contact.tblContact}(
        ${Contact.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Contact.colName} TEXT NOT NULL,
        ${Contact.colMobile} TEXT NOT NULL,
        ${Contact.colEmail} TEXT,
        ${Contact.colImg} TEXT,
        ${Contact.colFavorite} INTEGER
      )
    ''');
  }

  //CRUD of Contact
  Future<int> insertContact(Contact contact) async {
    Database db = await database;
    return await db.insert(Contact.tblContact, contact.toMap());
  }

  Future<List<Map<String, dynamic>>> fetchContacts() async {
    Database db = await database;
    return await db.query(Contact.tblContact);
    // return contacts.length == 0
    //     ? []
    //     : contacts.map((e) => Contact.fromMap(e)).toList();
  }

  Future<int> deleteContact(int id) async {
    Database db = await database;
    return await db.delete(Contact.tblContact,
        where: '${Contact.colId}=?', whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async {
    Database db = await database;
    return db.update(Contact.tblContact, contact.toMap(),
        where: '${Contact.colId}=?', whereArgs: [contact.id]);
  }
}
