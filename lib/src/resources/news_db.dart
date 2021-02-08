import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';

final String tableName = "Items";
final String columnId = "id";

class NewsDb {
  Database db;

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, "items.db");

    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute("""
        CREATE TABLE $tableName
        (
          $columnId INTEGER PRIMARY KEY,
          type TEXT,
          by TEXT,
          time INTEGER,
          text TEXT,
          parent INTEGER,
          kids BLOB,
          dead INTEGER,
          deleted INTEGER,
          url TEXT,
          scroe INTEGER,
          title TEXT,
          descendants INTEGER          
        )
        """);
    });
  }

  Future<ItemModel> fetchItem(int id) async {
    final List<Map> maps = await db.query(tableName,
        columns:
            null, //optional can pass in a list of columns like: ["id, text"]etc.. but we need all, so we pass in null
        where: "$columnId = ?",
        whereArgs: [id] //security against sql injection
        );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  Future<int> addItem(ItemModel item) {
    return db.insert(tableName, item.toDbMap());
  }
}