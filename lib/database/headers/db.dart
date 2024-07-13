import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  DB._();

  static final DB instance = DB._();

  static Database? _database;

  get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDataBase();
      return _database;
    }
  }

  Future<Database> _initDataBase() async {
    return await openDatabase(
        join(await getDatabasesPath(), 'cryptocurrency.db'),
        version: 1,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(_account);
    await db.execute(_wallet);
    await db.execute(_historic);
    await db.insert('account', {'balance': 0});
  }

  String get _account => '''
  CREATE TABLE account(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    balance REAL
  );
''';

  String get _wallet => '''
  CREATE TABLE wallet(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    currencyAbbreviation TEXT,
    currencyName TEXT,
    quantity TEXT    
  );
''';

  String get _historic => '''
  CREATE TABLE historic(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date INT,
    type TEXT,
    currencyName TEXT,
    currencyAbbreviation TEXT,
    value REAL,
    quantity TEXT   
  );
''';
}

enum DBTables {
  account,
  wallet,
  historic,
}
