import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ride_sharing/models/confirm_ride.dart'; // Import your RideDetails model

///
/// This controller handles sending ride requests to the backend API.
/// Author: Ictu3091081
/// Created at: August 2024
///
class RideRequestController {
  final String baseUrl = 'http://your-backend-url/api'; // Update with your backend URL

  /// Sends a ride request to the backend API.
  ///
  /// [rideDetails] The details of the ride request to be sent.
  /// Returns a [Future<bool>] indicating whether the ride request was successful.
  Future<bool> requestRide(RideDetails rideDetails) async {
    // Send a POST request to the backend API to create a new ride request
    final response = await http.post(
      Uri.parse('$baseUrl/rides'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'pickup_address': rideDetails.pickupAddress,
        'dropoff_address': rideDetails.dropoffAddress,
        'estimated_fare': rideDetails.estimatedFare,
      }),
    );

    if (response.statusCode == 201) {
      // If the status code is 201 (Created), return true indicating success
      return true;
    } else {
      // Otherwise, return false indicating failure
      return false;
    }
  }
}
