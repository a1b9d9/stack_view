import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'database_config.dart';
import 'database_structure_tables.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  // Private constructor for singleton
  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  // Getter for database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initializeDatabase() async {
    var dir = await getApplicationDocumentsDirectory();
    var path = join(dir.path, DatabaseConfig.nameDatabase);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
  onOpen: _onOpen,
    );
  }

  // Configure the database when it's opened
  Future<void> _onOpen(Database db) async {
    // Set pragmas using rawQuery instead of execute
    await db.rawQuery('PRAGMA foreign_keys = ON');
    await db.rawQuery('PRAGMA journal_mode = WAL');
    await db.rawQuery('PRAGMA busy_timeout = 5000');
  }

  // Create the tables
  Future<void> _onCreate(Database db, int version) async {
    // Create tables in a transaction
    await db.transaction((txn) async {
      for (String createTable in DatabaseStructureTables.createAllTables) {
        await txn.execute(createTable);
      }
    });
  }

  // Insert operation with error handling and transaction
  Future<int> insert(String table, Map<String, dynamic> values) async {
    try {
      final db = await database;
      return await db.transaction((txn) async {
        return await txn.insert(table, values);
      });
    } catch (error) {
      if (kDebugMode) {
        print('Insert operation failed: $error');
      }
      return -1;
    }
  }

  // Insert a list of data with error handling and transaction
  Future<int> insertList(
      String table, List<Map<String, dynamic>> valuesList) async {
    try {
      final db = await database;
      return await db.transaction((txn) async {
        int count = 0;
        for (var values in valuesList) {
          // Use INSERT OR REPLACE to handle duplicate primary keys
          await txn.rawInsert(
            'INSERT OR REPLACE INTO $table (${values.keys.join(', ')}) VALUES (${List.filled(values.length, '?').join(', ')})',
            values.values.toList(),
          );
          count++;
        }
        return count;
      });
    } catch (error) {
      if (kDebugMode) {
        print('Insert list operation failed: $error');
      }
      return -1;
    }
  }

  // Update operation with error handling and transaction
  Future<int> update(String table, Map<String, dynamic> values, String where,
      List<dynamic> whereArgs) async {
    try {
      final db = await database;
      return await db.transaction((txn) async {
        return await txn.update(table, values, where: where, whereArgs: whereArgs);
      });
    } catch (error) {
      if (kDebugMode) {
        print('Update operation failed: $error');
      }
      return -1;
    }
  }

  // Delete operation with error handling and transaction
  Future<int> delete(
      {required String table,
      required String where,
      required List<dynamic> whereArgs}) async {
    try {
      final db = await database;
      return await db.transaction((txn) async {
        return await txn.delete(table, where: where, whereArgs: whereArgs);
      });
    } catch (error) {
      if (kDebugMode) {
        print('Delete operation failed: $error');
      }
      return -1;
    }
  }

  // Delete all data in a table with transaction
  Future<int> deleteAllData(String table) async {
    try {
      final db = await database;
      return await db.transaction((txn) async {
        return await txn.delete(table);
      });
    } catch (error) {
      if (kDebugMode) {
        print('Delete all data operation failed: $error');
      }
      return -1;
    }
  }

  // Query operation (Read) with optional pagination and error handling
  Future<List<Map<String, dynamic>>> query(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
    int? limit,
    int? offset,
  }) async {
    try {
      final db = await database;
      return await db.query(
        table,
        where: where,
        whereArgs: whereArgs,
        limit: limit,
        offset: offset,
      );
    } catch (error) {
      if (kDebugMode) {
        print('Query operation failed: $error');
      }
      return [];
    }
  }

  // Method to get a single row based on a condition
  Future<Map<String, dynamic>?> getOne(
      {required String table,
      required String where,
      required List<dynamic> whereArgs}) async {
    try {
      final db = await database;
      List<Map<String, dynamic>> result = await db.query(
        table,
        where: where,
        whereArgs: whereArgs,
        limit: 1,
      );

      return result.isNotEmpty ? result.first : null;
    } catch (error) {
      if (kDebugMode) {
        print('Get one operation failed: $error');
      }
      return null;
    }
  }

  // Execute a custom SQL query with error handling
  Future<List<Map<String, dynamic>>> rawQuery(String sql,
      [List<dynamic>? arguments]) async {
    try {
      final db = await database;
      return await db.rawQuery(sql, arguments);
    } catch (error) {
      if (kDebugMode) {
        print('Raw query operation failed: $error');
      }
      return [];
    }
  }

  Future<int> getCount(String table) async {
    try {
      final db = await database;
      final result = await db.rawQuery('SELECT COUNT(*) FROM $table');
      final count = Sqflite.firstIntValue(result);
      return count ?? 0;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting count from $table: $e');
      }
      return 0;
    }
  }
}
