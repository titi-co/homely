import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteUtils {
  Future<Database> db() async {
    final path = await getDatabasesPath();
    final localDB = join(path, "banco.db");

    Database db = await openDatabase(
      localDB,
      version: 1,
      onCreate: (db, version) {
        String sql =
            "CREATE TABLE vehicles (id INTEGER PRIMARY KEY AUTOINCREMENT, model VARCHAR, color VARCHAR, propertyid VARCHAR)";
        db.execute(sql);
      },
    );

    // print(response);

    return db;
  }
}
