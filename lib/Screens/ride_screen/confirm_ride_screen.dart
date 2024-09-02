import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/Controller/ride/ride_controller.dart';
import 'package:ride_sharing/models/confirm_ride.dart'; // Import the model

///
/// This is the class for the ride confirmation screen.
/// Author: Ictu3091081
/// Created at: August 2024
///
class ConfirmRideScreen extends StatelessWidget {
  // Ride details passed to this screen
  final RideDetails rideDetails;

  // Constructor for initializing the screen with ride details
  ConfirmRideScreen({required this.rideDetails});

  // Instance of RideRequestController for handling ride requests
  final RideRequestController _rideRequestController = RideRequestController();

  ///
  /// Requests a ride confirmation by calling the requestRide method
  /// on the RideRequestController. Displays a success or failure snackbar
  /// based on the result of the ride request.
  ///
  void _confirmRide() async {
    try {
      final success = await _rideRequestController.requestRide(rideDetails);
      if (success) {
        Get.snackbar(
          'Success',
          'Ride Confirmed', // Success message
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.back(); // Go back to the previous screen
      } else {
        Get.snackbar(
          'Failed',
          'Failed to Confirm Ride', // Failure message
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      // Display error message if an exception occurs
      Get.snackbar(
        'Error',
        'Error: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Confirm Ride')), // Title of the confirmation screen
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pickup Address:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ), // Label for pickup address
            SizedBox(height: 8),
            Text(rideDetails.pickupAddress), // Display pickup address
            SizedBox(height: 16),
            Text(
              'Dropoff Address:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ), // Label for dropoff address
            SizedBox(height: 8),
            Text(rideDetails.dropoffAddress), // Display dropoff address
            SizedBox(height: 16),
            Text(
              'Estimated Fare:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ), // Label for estimated fare
            SizedBox(height: 8),
            Text('\$${rideDetails.estimatedFare.toStringAsFixed(2)}'), // Display estimated fare
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _confirmRide, // Call _confirmRide when button is pressed
                child: Text('Confirm Ride'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
