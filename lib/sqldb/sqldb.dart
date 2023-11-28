import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db ;
  Future<Database?> get db async {
    if (_db == null){
      return _db = await intialDb();
    }
    else{
      return _db ;
    }
  }

  intialDb()async{
    String databasepath = await getDatabasesPath();
    String path = join(databasepath,'yousry.db');
    Database mydb = await openDatabase(path,onCreate: _onCreate,version: 1,onUpgrade: _onUpgrade);
    return mydb;

  }
  _onUpgrade (Database db, int oldversion , int newversion){
    print('done upgrade');
  }
  _onCreate(Database db , int version) async {
    await db.execute('''
    CREATE TABLE 'notes' (
    "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "note" TEXT NOT NULL
    )
    ''');
    print('create database and table');
  }
  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response =await mydb!.rawQuery(sql);
    return response;
  }
  insertData(String sql) async {
    Database? mydb = await db;
    int response =await mydb!.rawInsert(sql);
    return response;
  }
  updateData(String sql) async {
    Database? mydb = await db;
    int response =await mydb!.rawUpdate(sql);
    return response;
  }
  deleateData(String sql) async {
    Database? mydb = await db;
    int response =await mydb!.rawDelete(sql);
    return response;
  }
  mydeletedatabase()async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'yousry.db');
    await deleteDatabase(path);
  }
}

