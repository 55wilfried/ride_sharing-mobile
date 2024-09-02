import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/Controller/user_controller/user_controller.dart';
 // Updated typo from 'singup_screen.dart' to 'signup_screen.dart'
import 'package:ride_sharing/Screens/auth_screen/singup_screen.dart';
import 'package:ride_sharing/Screens/ride_screen/map_screen.dart';
import 'package:ride_sharing/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// This is the class for the login screen.
/// Author: Ictu3091081
/// Created at: August 2024
///
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers for the email and password text fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Instance of UserController for handling user-related operations
  final UserController _userController = UserController();

  ///
  /// Saves the authentication token to shared preferences for persistent storage.
  ///
  /// [token] - The token string to be saved.
  ///
  void _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  ///
  /// Handles the login process by collecting input from text fields,
  /// invoking the login method from UserController, and navigating to
  /// the MapScreen upon successful login.
  ///
  /// Shows appropriate snack bars based on success or failure of login.
  ///
  void _login() async {
    final email = _emailController.text; // Collects email from the email controller
    final password = _passwordController.text; // Collects password from the password controller
    final user = User(email: email, password: password); // Creates a User object

    try {
      final token = await _userController.login(user); // Attempts login and retrieves token

      if (token.isNotEmpty) {
        _saveToken(token); // Saves the token if login is successful
        Get.to(MapScreen(
          pickupAddress: 'Your pickup address here',
          dropoffAddress: 'Your dropoff address here',
        )); // Navigates to the MapScreen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Successful')), // Displays success message
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Failed')), // Displays failure message
        );
      }
    } catch (e) {
      // Handle exceptions, such as when the backend is unreachable
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')), // Displays error message
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')), // Title of the login screen
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the form
        child: Column(
          children: [
            TextField(
              controller: _emailController, // Controller for email input
              decoration: InputDecoration(labelText: 'Email'), // Label for the email field
              keyboardType: TextInputType.emailAddress, // Ensure correct keyboard type
            ),
            TextField(
              controller: _passwordController, // Controller for password input
              decoration: InputDecoration(labelText: 'Password'), // Label for the password field
              obscureText: true, // Hides password text
            ),
            SizedBox(height: 20), // Spacing between fields and button
            ElevatedButton(
              onPressed: _login, // Calls _login function when pressed
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Get.to(RegistrationScreen()); // Navigates to the registration screen
              },
              child: Text('Don\'t have an account? Register'),
            ),
          ],
        ),
      ),
    );
  }
}
