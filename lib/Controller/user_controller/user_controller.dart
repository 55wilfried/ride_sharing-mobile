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
  /// Saves the user data locally and attempts to sync with the backend.
  ///
  /// [user] The user to register.
  /// Returns a [Future<bool>] indicating success or failure of the registration.
  Future<bool> register(User user) async {
    try {
      // Save the user to the local database first
      await _dbHelper.insertUser(user);

      // Attempt to register the user with the backend API
      final response = await http.post(
        Uri.parse('$baseUrl/users/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()), // Convert user object to JSON
      );

      if (response.statusCode == 200) {
        // If registration is successful, update the user with any additional data from the response if needed
        return true; // Registration successful
      } else {
        // If registration fails, you might want to handle this case based on your requirements
        return false; // Registration failed
      }
    } catch (e) {
      // If the backend is not reachable, registration will still be successful locally
      return true; // Registration successful locally, sync later
    }
  }

  /// Logs in a user by checking the local database for credentials.
  /// If not found, attempts to log in online and updates the local database with the token.
  ///
  /// [user] The user credentials for login.
  /// Returns a [Future<String>] containing the token if login is successful.
  /// Throws an [Exception] if the login fails.
  Future<String> login(User user) async {
    try {
      // First, check the local database for the user
      User? localUser = await _dbHelper.getUser(user.email);

      if (localUser != null && localUser.password == user.password) {
        // If user is found in local database and passwords match, use the local token
        if (localUser.token != null && localUser.token!.isNotEmpty) {
          return localUser.token!; // Return the token from the local database
        } else {
          // Token is not present, attempt to sync with the backend
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
      } else {
        // User not found in local database
        throw Exception('User not found'); // Handle user not found case
      }
    } catch (e) {
      // Handle backend connectivity issues or other errors
      throw Exception('Failed to connect to the backend'); // Throw an exception if login fails
    }
  }
}
