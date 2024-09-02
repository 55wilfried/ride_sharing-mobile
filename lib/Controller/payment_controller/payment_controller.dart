import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ride_sharing/models/payment.dart'; // Import the model

///
/// This class handles payment processing requests.
/// Author: Ictu3091081
/// Created at: September 2024
///
class PaymentController {
  final String baseUrl = 'http://your-backend-url.com'; // Replace with your actual backend URL

  /// Processes a payment request by sending payment details to the server.
  ///
  /// [payment] The [Payment] object containing payment details to be sent to the server.
  /// Returns a [Future<bool>] indicating whether the payment was processed successfully.
  /// Returns `true` if the server responds with a status code of 200 (OK), otherwise `false`.
  Future<bool> processPayment(Payment payment) async {
    // Send a POST request to the payments endpoint with payment details
    final response = await http.post(
      Uri.parse('$baseUrl/payments'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payment.toJson()),
    );

    // Check if the response status code is 200 (OK)
    return response.statusCode == 200;
  }
}
