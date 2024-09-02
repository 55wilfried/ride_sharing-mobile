import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/Screens/splash_screen.dart';
import 'Screens/ride_screen/map_screen.dart'; // Import your MapScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ride Sharing App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
