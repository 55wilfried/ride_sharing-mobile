import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/Controller/feedback_ccontroller/feedback_controller.dart';
import 'package:ride_sharing/models/feedbacks.dart'; // Import the feedback model

///
/// This is the class for the feedback screen.
/// Author: Ictu3091081
/// Created at: August 2024
///
class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  // Controllers for the comments and rating text fields
  final _commentsController = TextEditingController();
  final _ratingController = TextEditingController();

  // Instance of FeedbackController for handling feedback-related operations
  final FeedbackController _feedbackController = FeedbackController(); // Use Get.find() if registered with GetX

  ///
  /// Submits the feedback by collecting input from text fields,
  /// validating the input, and sending it to the backend via FeedbackController.
  ///
  /// Displays appropriate snack bars based on success or failure of submission.
  ///
  void _submitFeedback() async {
    final comments = _commentsController.text; // Collects comments from the comments controller
    final rating = int.tryParse(_ratingController.text) ?? 0; // Collects and parses rating from the rating controller

    // Validates input
    if (comments.isEmpty || rating < 1 || rating > 5) {
      Get.snackbar(
        'Invalid Input',
        'Please enter valid comments and rating (1-5).',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Creates a Feedbacks object
    final feedback = Feedbacks(
      id: 0, // ID is set to 0, backend will generate the actual ID
      comments: comments,
      rating: rating,
      timestamp: DateTime.now(), // Sets the current timestamp
    );

    try {
      // Submits feedback and checks success
      final success = await _feedbackController.submitFeedback(feedback);
      if (success) {
        Get.snackbar(
          'Success',
          'Feedback Submitted',
          snackPosition: SnackPosition.BOTTOM,
        );
        // Optionally, clear the fields after submission
        _commentsController.clear();
        _ratingController.clear();
      } else {
        Get.snackbar(
          'Failed',
          'Feedback Submission Failed',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error: ${e.toString()}', // Displays error message if exception occurs
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Feedback')), // Title of the feedback screen
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the form
        child: Column(
          children: [
            TextField(
              controller: _commentsController, // Controller for comments input
              decoration: InputDecoration(labelText: 'Comments'), // Label for the comments field
              maxLines: 4, // Allows for multiple lines of input
            ),
            TextField(
              controller: _ratingController, // Controller for rating input
              decoration: InputDecoration(labelText: 'Rating (1-5)'), // Label for the rating field
              keyboardType: TextInputType.number, // Allows only numerical input
            ),
            SizedBox(height: 20), // Spacing between fields and button
            ElevatedButton(
              onPressed: _submitFeedback, // Calls _submitFeedback function when pressed
              child: Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}
