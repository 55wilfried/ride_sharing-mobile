import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/Controller/user_controller/user_controller.dart';
import 'package:ride_sharing/Screens/auth_screen/login.dart';
import 'package:ride_sharing/models/user.dart';

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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Successful')), // Displays success message
        );
        Get.off(LoginScreen()); // Redirects to SignInScreen after registration
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
              keyboardType: TextInputType.emailAddress, // Ensure correct keyboard type
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
            TextButton(
              onPressed: () {
                Get.to(LoginScreen()); // Navigate to SignInScreen if the user already has an account
              },
              child: Text('Already have an account? Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
