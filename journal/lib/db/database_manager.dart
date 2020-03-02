import 'package:sqflite/sqflite.dart';
import 'journal_entry_dto.dart';

class DatabaseManager {

  static const String DATABASE_FILENAME = 'journal.sqlite3.db';
  static const String SQL_CREATE_SCHEMA = 'CREATE TABLE IF NOT EXISTS journal_entries(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, body TEXT NOT NULL, rating INTEGER NOT NULL, date TEXT NOT NULL);';
  static const String SQL_INSERT = 'INSERT INTO journal_entries(title, body, rating, date) VALUES(?, ?, ?, ?);';

  static DatabaseManager _instance;

  final Database db;

  DatabaseManager._({Database database}) : db = database;

  factory DatabaseManager.getInstance() {
    assert(_instance != null);
    return _instance;
  }


  static Future initalize() async {
    final db = await openDatabase(DATABASE_FILENAME,
    version: 1,
    onCreate: (Database db, int version) async {
      createTables(db, SQL_CREATE_SCHEMA);
    }
    );
    _instance = DatabaseManager._(database:db);
  }

  static void createTables(Database db, String sql) async {
    await db.execute(sql);
  }

  void saveJournalEntry({JournalEntryDTO dto}) {
    db.transaction((txn) async {
      await txn.rawInsert(SQL_INSERT,
      [dto.title, dto.body, dto.rating, dto.dateTime]
      );
    });
  }

}


// DatabaseManager.initalize();
// DatabaseManager.getInstance();

//     if(_instance == null) {
//       Database db = openDatabase(DATABASE_FILENAME);
//       _instance = DatabaseManager._(database: db);
//     }