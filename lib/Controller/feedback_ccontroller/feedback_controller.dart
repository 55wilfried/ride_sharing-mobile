import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ride_sharing/models/feedbacks.dart'; // Import the model

///
/// This class handles feedback-related operations with the backend.
/// Author: Ictu3091081
/// Created at: September 2024
///
class FeedbackController {
  final String baseUrl = 'http://your-backend-url/api'; // Replace with your actual backend URL

  /// Submits feedback to the server.
  ///
  /// [feedback] The [Feedbacks] object containing feedback details to be sent to the server.
  /// Returns a [Future<bool>] indicating whether the feedback was submitted successfully.
  /// Returns `true` if the server responds with a status code of 201 (Created), otherwise `false`.
  Future<bool> submitFeedback(Feedbacks feedback) async {
    // Send a POST request to the feedbacks endpoint with feedback details
    final response = await http.post(
      Uri.parse('$baseUrl/feedbacks'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'comments': feedback.comments,
        'rating': feedback.rating,
        'timestamp': feedback.timestamp.toIso8601String(),
      }),
    );

    // Check if the response status code is 201 (Created)
    return response.statusCode == 201;
  }

  /// Fetches the list of feedbacks from the server.
  ///
  /// Returns a [Future<List<Feedbacks>>] containing a list of feedback objects.
  /// Throws an [Exception] if the server fails to respond with status code 200 (OK).
  Future<List<Feedbacks>> getFeedbacks() async {
    // Send a GET request to the feedbacks endpoint
    final response = await http.get(Uri.parse('$baseUrl/feedbacks'));

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      // Decode the response body into a list of feedbacks
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Feedbacks.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load feedback');
    }
  }
}
