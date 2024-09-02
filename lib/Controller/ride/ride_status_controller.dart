import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ride_sharing/models/ride_status.dart'; // Import your RideStatus model

///
/// This controller handles fetching the status of a specific ride from the backend API.
/// Author: Ictu3091081
/// Created at: August 2024
///
class RideStatusController {
  final String baseUrl = 'http://your-backend-url.com'; // Replace with your backend URL

  /// Fetches the status of a ride from the backend API.
  ///
  /// [rideId] The ID of the ride whose status is to be fetched.
  /// Returns a [Future<RideStatus>] containing the ride status.
  /// Throws an [Exception] if the request fails.
  Future<RideStatus> getRideStatus(int rideId) async {
    // Send a GET request to fetch the ride status
    final response = await http.get(
      Uri.parse('$baseUrl/rides/status/$rideId'),
    );

    if (response.statusCode == 200) {
      // If the request is successful, decode the response body
      final data = json.decode(response.body);
      // Convert the JSON data into a RideStatus object
      return RideStatus.fromJson(data);
    } else {
      // Throw an exception if the request fails
      throw Exception('Failed to load ride status');
    }
  }
}
