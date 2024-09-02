import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/Controller/user_controller/user_controller.dart';
import 'package:ride_sharing/Screens/auth_screen/singIn_screen.dart';
import 'package:ride_sharing/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// This is the class for the registration screen.
/// Author: Ictu3091081
/// Created at: August 2024
///
class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
  Future<void> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  ///
  /// Handles the registration process by collecting input from text fields,
  /// invoking the register method from UserController, and navigating to
  /// the LoginScreen upon successful registration.
  ///
  /// Shows appropriate snack bars based on success or failure of registration.
  ///
  Future<void> _register() async {
    final email = _emailController.text; // Collects email from the email controller
    final password = _passwordController.text; // Collects password from the password controller
    final user = User(email: email, password: password); // Creates a User object

    try {
      final isRegistered = await _userController.register(user); // Attempts registration
      if (isRegistered) {
        // If you receive a token after registration, you can save it
        // Here, assume the token is obtained after successful registration
        // This token might come from the server response
        String token = "some_token"; // Replace with actual token if available
        await _saveToken(token); // Saves the token if registration is successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Successful')), // Displays success message
        );
        Get.off(LoginScreen()); // Redirects to login screen after registration
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Failed')), // Displays failure message
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')), // Displays error message
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')), // Title of the registration screen
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the form
        child: Column(
          children: [
            TextField(
              controller: _emailController, // Controller for email input
              decoration: InputDecoration(labelText: 'Email'), // Label for the email field
            ),
            TextField(
              controller: _passwordController, // Controller for password input
              decoration: InputDecoration(labelText: 'Password'), // Label for the password field
              obscureText: true, // Hides password text
            ),
            SizedBox(height: 20), // Spacing between fields and button
            ElevatedButton(
              onPressed: _register, // Calls _register function when pressed
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
