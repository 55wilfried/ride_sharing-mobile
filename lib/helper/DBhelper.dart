import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ride_sharing/models/user.dart';

///
/// This class handles database operations related to the `User` model.
/// Author: Ictu3091081
/// Created at: September 2024
///
class DBHelper {
  // Singleton instance of the database helper
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  Database? _database;

  /// Provides access to the database.
  /// Initializes the database if it is not already initialized.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Initializes the database.
  /// Creates the `users` table if it does not exist.
  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(email TEXT PRIMARY KEY, password TEXT, token TEXT)",
        );
      },
      version: 1,
    );
  }

  /// Inserts a user into the database.
  ///
  /// [user] The [User] object to be inserted into the database.
  /// If a user with the same email already exists, it will be replaced.
  Future<void> insertUser(User user) async {
    final db = await database;
    try {
      await db.insert(
        'users',
        user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting user: $e'); // Logging error
    }
  }

  /// Retrieves a user from the database by email.
  ///
  /// [email] The email of the user to be retrieved.
  /// Returns a [User] object if a user with the given email is found, otherwise returns `null`.
  Future<User?> getUser(String email) async {
    final db = await database;
    try {
      final maps = await db.query(
        'users',
        where: "email = ?",
        whereArgs: [email],
      );

      if (maps.isNotEmpty) {
        return User.fromJson(maps.first);
      } else {
        return null;
      }
    } catch (e) {
      print('Error retrieving user: $e'); // Logging error
      return null;
    }
  }

  /// Updates a user's information in the database.
  ///
  /// [user] The [User] object with updated information.
  /// The user is identified by their email.
  Future<void> updateUser(User user) async {
    final db = await database;
    try {
      await db.update(
        'users',
        user.toJson(),
        where: "email = ?",
        whereArgs: [user.email],
      );
    } catch (e) {
      print('Error updating user: $e'); // Logging error
    }
  }
}
