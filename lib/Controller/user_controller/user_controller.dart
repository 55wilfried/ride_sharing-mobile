import 'package:http/http.dart' as http;
import 'package:ride_sharing/helper/DBhelper.dart';
import 'dart:convert';
import 'package:ride_sharing/models/user.dart'; // Import your User model

///
/// This controller handles user registration and login. It interacts with a backend API and updates the local database.
/// Author: Ictu3091081
/// Created at: August 2024
///
class UserController {
  final String baseUrl = 'http://your-backend-url.com'; // Replace with your backend URL
  final DBHelper _dbHelper = DBHelper(); // Instance of DBHelper for local database operations

  /// Registers a new user by sending their data to the backend API.
  ///
  /// [user] The user to register.
  /// Returns a [Future<bool>] indicating success or failure of the registration.
  Future<bool> register(User user) async {
    // Send a POST request to the backend API with the user data
    final response = await http.post(
      Uri.parse('$baseUrl/users/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()), // Convert user object to JSON
    );

    if (response.statusCode == 200) {
      // If registration is successful, save the user to the local database
      await _dbHelper.insertUser(user);
      return true; // Registration successful
    } else {
      return false; // Registration failed
    }
  }

  /// Logs in a user by first checking the local database for credentials.
  /// If not found, sends the credentials to the backend API and receives a token.
  ///
  /// [user] The user credentials for login.
  /// Returns a [Future<String>] containing the token if login is successful.
  /// Throws an [Exception] if the login fails.
  Future<String> login(User user) async {
    // First, check the local database for the user
    User? localUser = await _dbHelper.getUser(user.email);

    if (localUser != null && localUser.password == user.password) {
      // If user is found in local database and passwords match, use the local token
      return localUser.token ?? ''; // Return the token from the local database
    } else {
      // If not found or password does not match, attempt to log in online
      final response = await http.post(
        Uri.parse('$baseUrl/users/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()), // Convert user object to JSON
      );

      if (response.statusCode == 200) {
        // If login is successful, extract the token from the response
        final data = json.decode(response.body);
        final token = data['token']; // Extract token from response

        // Update the user object with the token
        user = User(
          email: user.email,
          password: user.password,
          token: token,
        );

        // Update the local database with the new token
        await _dbHelper.updateUser(user);
        return token; // Return the token
      } else {
        throw Exception('Failed to log in'); // Throw an exception if login fails
      }
    }
  }
}
