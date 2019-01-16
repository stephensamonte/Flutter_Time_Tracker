// For Date Formatter to determine Date Key for storage
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import './Documents.dart' as Documents;
import '../MockData.dart' as MockData;

// Determines key to store data
String getDayKey(DateTime selectedDate) {
  // Format example: 2019-01-15
  return new DateFormat(('yyyy-MM-dd')).format(selectedDate);
}

// Retrieve day data to display to user
Future<List<Documents.UserDataItem>> getDayData(String storageKey) async {
  // todo Create manifest database that keeps track of user created categories

  // Get database
  String allDataTableName = "allData";

  DatabaseHelper dbHelper = new DatabaseHelper();

  // retrieve singe database list
  Database dataDb = await dbHelper.getDatabase(allDataTableName);

  MockData.item1.dayKey = storageKey;

//  // add an item to the database
  int result = await dbHelper.insertItem(allDataTableName, dataDb, MockData.item1);
  print("result: " + result.toString());

  List<Documents.UserDataItem> dayData = await dbHelper.getDayData(dataDb, allDataTableName, storageKey);

  return dayData;
}

// ------------------------------------------------------------------
// number of tables
//

class DatabaseHelper {

  // Database name
  String dbName = "data";

  // Table Name
  String tableName;

  // Table Columns
  String columnId = 'id';
  String columnCategory = 'category';
  String columnDuration = "duration";
  String columnDayKey = "dayKey";
  String columnTimeModified = "timeModified";

  String databasePath;

  // get the database
  Future<Database> getDatabase(String nameTable) async {
    tableName = nameTable;

    return await startDatabase();

  }

  // Create the database
  startDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, '$dbName.db');

    databasesPath = path;
//    // delete database
//    await deleteDatabase(path); // for testing

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  // on create for the table
  _onCreate(Database db, int newVersion) async {

    // Must add a table
    return await db.execute(
        'CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, $columnDayKey TEXT, $columnCategory TEXT, $columnDuration INTEGER, $columnTimeModified TEXT)');
  }

  // Add item to the database
  Future<int> insertItem(String nameTable, Database database, Documents.UserDataItem item) async {

    tableName = nameTable;

//    var dbClient = await database;

    int result = await database.insert(tableName, item.toMap());

//    // Insert some records in a transaction
//    await database.transaction((txn) async {
//      int id1 = await txn.rawInsert(
//          'INSERT INTO $tableName($columnDuration, $columnTimeDay, $columnTimeModified) VALUES("some name", 1234, 456.789)');
//      print('inserted1: $id1');
//      int id2 = await txn.rawInsert(
//          'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
//          ['another name', 12345678, 3.1416]);
//      print('inserted2: $id2');
//    });

  return result;

  }

  Future<List<Documents.UserDataItem>> getDayData(Database dataDb, String nameTable, String dayKey) async {

    tableName = nameTable;

    // Find data matching for the day
    List<Map<String, dynamic>> records = await dataDb.rawQuery('SELECT * FROM "$tableName" WHERE dayKey= "$dayKey"');
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
    // delete database
    await deleteDatabase(databasePath); // for testing
  }
}

// Start database when app opened
// Close database when app closed


