import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/Controller/ride/ride_status_controller.dart';
import 'package:ride_sharing/models/ride_status.dart';

///
/// This screen displays the status of a ride. It retrieves the ride status using a ride ID and shows it to the user.
/// Author: Ictu3091081
/// Created at: August 2024
///
class RideStatusScreen extends StatefulWidget {
  @override
  _RideStatusScreenState createState() => _RideStatusScreenState();
}

class _RideStatusScreenState extends State<RideStatusScreen> {
  final RideStatusController _rideStatusController = RideStatusController(); // Controller to manage ride status
  late Future<RideStatus> _rideStatus; // Future object to hold the ride status data
  final int rideId = 1; // Example ride ID. This should be replaced with a dynamic ID as needed

  @override
  void initState() {
    super.initState();
    // Initialize the future to get ride status based on the ride ID
    _rideStatus = _rideStatusController.getRideStatus(rideId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ride Status'), // Title of the screen
      ),
      body: FutureBuilder<RideStatus>(
        future: _rideStatus, // The future that will provide the ride status
        builder: (context, snapshot) {
          // Handle different states of the future
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While the future is still loading, show a progress indicator
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If there's an error, show an error message
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // If data is available, show the ride status
            return Center(child: Text('Ride Status: ${snapshot.data!.status}'));
          } else {
            // If no data is available, show a default message
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
