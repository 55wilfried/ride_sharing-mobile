import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/Screens/auth_screen/login.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Get.to(LoginScreen());  // Navigate to the home screen
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/splash_logo.png'), // Add your splash logo here
      ),
    );
  }
}
