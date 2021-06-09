import 'dart:core' as prefix0;
import 'dart:core';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DbHelper {
  static Database _dbMem;

  Future init() async {
    final databasesPath = await getDbSharedPath();
    final String path = join(databasesPath, "demo.db");
    _dbMem = await openDatabase(path,
        version: 22,
        readOnly: false,
        onUpgrade: (Database db, int oldVersion, int newVersion) async {});
    print("Database created");
    await createTable();
    print("table created");

    // await insertData();
    // print("data inserted");
  }

  Future showData() async {
    await _dbMem.transaction((txn) async {
      List<Map> listMap = await txn.rawQuery("Select * from emp");
      print(listMap.toString());
    });
  }

  Future getDbSharedPath() async {
    MethodChannel _methodChannel =
        MethodChannel("thecove.hashcove.com/channel");
    return await _methodChannel.invokeMethod("getSharedPath");
  }

  Future createTable() async {
    await _dbMem.execute('CREATE TABLE IF NOT EXISTS emp (' +
        ' name TEXT ,' +
        ' dept TEXT ,' +
        ' id TEXT, PRIMARY KEY( id ) )');
    print("");
  }

  Future insertData() async {
    await _dbMem.transaction((txn) async {
      String query = "Insert into emp values(?,?,?)";
      txn.rawInsert(query, ["Dinesh", "IT", "100"]);
      txn.rawInsert(query, ["Xyz", "Account", "101"]);
      txn.rawInsert(query, ["Mno", "Sales", "102"]);
      txn.rawInsert(query, ["Pqr", "Production", "103"]);
    });
    print("");
  }
}
