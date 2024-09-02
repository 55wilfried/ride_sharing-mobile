import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/Screens/Payment/payment_.dart';
import 'package:ride_sharing/Screens/feedback_screen/feedback_screen.dart';
import 'package:ride_sharing/Screens/feedback_screen/view_feedback.dart';
import 'package:ride_sharing/Screens/ride_screen/address_search_screen.dart';
import 'package:ride_sharing/Screens/ride_screen/map_screen.dart';
import 'package:ride_sharing/Screens/ride_screen/ride_request_screen.dart';
import 'package:ride_sharing/Screens/ride_screen/ride_status_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Ride Sharing App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Ride Request'),
              onTap: () {
                Get.to(() => RideRequestScreen());
              },
            ),
            ListTile(
              title: Text('Ride Status'),
              onTap: () {
                Get.to(() => RideStatusScreen());
              },
            ),
            ListTile(
              title: Text('Address Search'),
              onTap: () {
                Get.to(() => AddressSearchScreen());
              },
            ),
            ListTile(
              title: Text('Payment'),
              onTap: () {
                Get.to(() => PaymentScreen());
              },
            ),
            ListTile(
              title: Text('Feedback'),
              onTap: () {
                Get.to(() => FeedbackScreen());
              },
            ),
            ListTile(
              title: Text('View Feedback'),
              onTap: () {
                Get.to(() => ViewFeedbackScreen());
              },
            ),
            // Add other menu items here
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the Ride Sharing App!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to MapScreen with example addresses
                Get.to(() => MapScreen(
                  pickupAddress: 'Example Pickup Address',
                  dropoffAddress: 'Example Dropoff Address',
                ));
              },
              child: Text('View Map'),
            ),
          ],
        ),
      ),
    );
  }
}
