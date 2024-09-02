import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/Controller/payment_controller/payment_controller.dart';
import 'package:ride_sharing/models/payment.dart'; // Import the payment model

///
/// This is the class for the payment screen.
/// Author: Ictu3091081
/// Created at: August 2024
///
class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // Controllers for handling user input in text fields
  final _amountController = TextEditingController();
  final _methodController = TextEditingController();

  // Instance of PaymentController for handling payment-related operations
  final PaymentController _paymentController = PaymentController(); // Use Get.find() if registered with GetX

  ///
  /// Handles the process of making a payment.
  /// Reads the amount and payment method from the controllers,
  /// creates a Payment object, and attempts to process the payment.
  ///
  void _processPayment() async {
    // Parse the amount from the input field, default to 0.0 if parsing fails
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    final method = _methodController.text;

    // Create a Payment object with the input data
    final payment = Payment(amount: amount, method: method);

    try {
      // Attempt to process the payment through the PaymentController
      final success = await _paymentController.processPayment(payment);
      if (success) {
        // Show success message if payment is processed successfully
        Get.snackbar(
          'Success',
          'Payment Successful',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        // Show failure message if payment processing fails
        Get.snackbar(
          'Failed',
          'Payment Failed',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      // Show error message if there is an exception during payment processing
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
      appBar: AppBar(title: Text('Payment')), // Title of the payment screen
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the form
        child: Column(
          children: [
            TextField(
              controller: _amountController, // Controller for amount input
              decoration: InputDecoration(labelText: 'Amount'), // Label for amount field
              keyboardType: TextInputType.number, // Numeric keyboard for amount input
            ),
            TextField(
              controller: _methodController, // Controller for payment method input
              decoration: InputDecoration(labelText: 'Payment Method'), // Label for method field
            ),
            SizedBox(height: 20), // Space between input fields and button
            ElevatedButton(
              onPressed: _processPayment, // Call _processPayment when button is pressed
              child: Text('Submit Payment'), // Button text
            ),
          ],
        ),
      ),
    );
  }
}
