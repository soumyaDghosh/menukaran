import 'package:menukaran/common/constants.dart';
import 'package:menukaran/models/desktop_model.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DataBaseHelper {
  static const int _version = 1;
  static const String _dbname = 'Desktops.db';

  static Future<Database> _getDb() async {
    databaseFactory = databaseFactoryFfi;
    return openDatabase(
      join(tempdir, _dbname),
      onCreate: (db, version) async => await db.execute(
          "CREATE TABLE Desktop(id INTEGER PRIMARY KEY, name TEXT NOT NULL, type TEXT NOT NULL, executable TEXT NOT NULL, filename TEXT NOT NULL, icon TEXT NULL, genericname TEXT NULL, comment TEXT NULL, onlyshowin TEXT NULL, tryexec TEXT NULL);"),
      version: _version,
    );
  }

  static Future<int> addDesktop(Desktop desktop) async {
    final db = await _getDb();
    return await db.insert(
      "Desktop",
      desktop.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> updateDesktop(Desktop desktop) async {
    final db = await _getDb();
    return await db.update(
      "Desktop",
      desktop.toJson(),
      where: 'id = ?',
      whereArgs: [desktop.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> deleteDesktop(Desktop desktop) async {
    final db = await _getDb();
    return await db.delete(
      "Desktop",
      where: 'id = ?',
      whereArgs: [desktop.id],
    );
  }

  static Future<List<Desktop>?> getAllDesktop() async {
    final db = await _getDb();
    final List<Map<String, dynamic>> maps = await db.query("Desktop");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(maps.length, (index) => Desktop.fromJson(maps[index]));
  }
}
