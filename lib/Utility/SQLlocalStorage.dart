// For Date Formatter to determine Date Key for storage
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import './Documents.dart' as Documents;

// Determines key to store data
String getDayKey(DateTime selectedDate) {
  // Format example: 2019-01-15
  return new DateFormat(('yyyy-MM-dd')).format(selectedDate);
}

resetDatabase() async {
  // create a database helper
  DatabaseHelper dbHelper = new DatabaseHelper();

  // reset the database
  dbHelper.resetDatabase();

}

// Retrieve day data to display to user
Future<List<Documents.UserDataItem>> getDayData(String storageKey) async {

  // create a database helper
  DatabaseHelper dbHelper = new DatabaseHelper();

  // open the database
  Database database = await dbHelper.getDatabase();

  // Get day data
  List<Documents.UserDataItem> dayData = await dbHelper.getDayData(database, storageKey);

  // close the database
  dbHelper.closeDatabase(database);

  return dayData;
}

// save item to database
Future<int> saveItemToDB(Documents.UserDataItem dataItem) async {

  // create a database helper
  DatabaseHelper dbHelper = new DatabaseHelper();

  // open the database
  Database database = await dbHelper.getDatabase();

  // add an item to the database
  int result = await dbHelper.insertItem(database, dataItem);

  // close the database
  dbHelper.closeDatabase(database);

  return result;


}

// delete item
Future<int> deleteItemInDB(Documents.UserDataItem dataItem) async {

  // create a database helper
  DatabaseHelper dbHelper = new DatabaseHelper();

  // open the database
  Database database = await dbHelper.getDatabase();

  // add an item to the database
  int result = await dbHelper.deleteItem(database, dataItem);

  // close the database
  dbHelper.closeDatabase(database);

  return result;

}


// ------------------------------------------------------------------

class DatabaseHelper {

  // Database name
  String dbName = "data";

  // Table Name
  String tableName = "allData";

  // Table Columns
  String columnId = 'id';
  String columnCategory = 'category';
  String columnDuration = "duration";
  String columnDayKey = "dayKey";
  String columnTimeModified = "timeModified";

//  Database database;

  // get the database
  Future<Database> getDatabase() async {
    return await startDatabase();
  }

  Future<String> getDatabasePath() async {
    String databasesPath = await getDatabasesPath();
    String databasePath = join(databasesPath, '$dbName.db');

    return databasePath;
  }

  // Create the database
  startDatabase() async {
    String path = await getDatabasePath();

//    // delete database
    //await deleteDatabase(path); // for testing

    Database db = await openDatabase(path, version: 1, onCreate: _onCreate);

    return db;
  }

  // on create for the table
  _onCreate(Database db, int newVersion) async {

    // Must add a table
    return await db.execute(
        'CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnDayKey TEXT, $columnCategory TEXT, $columnDuration INTEGER, $columnTimeModified TEXT)');
  }

  // Add item to the database
  Future<int> insertItem(Database database, Documents.UserDataItem item) async {

    int result;
    if(item.id == null){
      // not in db so insert
      result = await database.insert(tableName, item.toMap());

    } else {
      // already in db so just update
      result = await database.update(tableName, item.toMap());
    }

    return result;
  }

  // Add item to the database
  Future<int> deleteItem(Database database, Documents.UserDataItem item) async {

    int result;
    if(item.id == null){
      // not in db so insert
//      result = await database.insert(tableName, item.toMap());
    result = 2;

    } else {
      // already in db so just update
      result = await database.delete(tableName, where: '$columnId = ?', whereArgs: [item.id]);

    }

    return result;
  }

  Future<List<Documents.UserDataItem>> getDayData(Database database, String dayKey) async {

    // Find data matching for the day
    List<Map<String, dynamic>> records = await database.rawQuery('SELECT * FROM "$tableName" WHERE dayKey= "$dayKey"');
    print(records.toString());

    // Convert map to UserDataItem items
    List<Documents.UserDataItem> itemRecords = new List();

    for(Map<String, dynamic> record in records){
      // convert ot readable
      Documents.UserDataItem singleItem = new Documents.UserDataItem.fromMap(record);
      itemRecords.add(singleItem);
    }

    // Read all data
//  List<Map<String, dynamic>> records = await dataDb.query('allData');
//  print(records.toString());

    // Read data matching specific day

//  List<Map<String, dynamic>> records = await dataDb.rawQuery('SELECT * FROM "$allDataTableName"');

    return itemRecords;
  }

  // close database
  void closeDatabase(Database database) async {
    // Close the database
    await database.close();
  }

  // reset the database
  Future resetDatabase() async {
    String path = await getDatabasePath();

    // delete database
    await deleteDatabase(path); // for testing
  }
}

// Start database when app opened
// Close database when app closed


