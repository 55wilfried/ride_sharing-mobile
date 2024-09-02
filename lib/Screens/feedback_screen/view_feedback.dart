import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/Controller/feedback_ccontroller/feedback_controller.dart';
import 'package:ride_sharing/models/feedbacks.dart'; // Import the feedback model

///
/// This is the class for the view feedback screen.
/// Author: Ictu3091081
/// Created at: August 2024
///
class ViewFeedbackScreen extends StatefulWidget {
  @override
  _ViewFeedbackScreenState createState() => _ViewFeedbackScreenState();
}

class _ViewFeedbackScreenState extends State<ViewFeedbackScreen> {
  // Instance of FeedbackController for handling feedback-related operations
  final FeedbackController _feedbackController = FeedbackController(); // Use Get.find() if registered with GetX

  // Future to hold the list of feedbacks
  late Future<List<Feedbacks>> _feedbacks;

  @override
  void initState() {
    super.initState();
    // Initialize the future to fetch feedbacks
    _feedbacks = _feedbackController.getFeedbacks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Feedback')), // Title of the feedback view screen
      body: FutureBuilder<List<Feedbacks>>(
        future: _feedbacks, // The future to build the widget from
        builder: (context, snapshot) {
          // While waiting for data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          // If there is an error
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // If data is available and not empty
          else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length, // Number of feedbacks
              itemBuilder: (context, index) {
                final feedback = snapshot.data![index]; // Get individual feedback
                return ListTile(
                  title: Text('Rating: ${feedback.rating}'), // Display rating
                  subtitle: Text(feedback.comments), // Display comments
                  trailing: Text(feedback.timestamp.toLocal().toString()), // Display timestamp
                );
              },
            );
          }
          // If no data is available
          else {
            return Center(child: Text('No feedback available.'));
          }
        },
      ),
    );
  }
}
