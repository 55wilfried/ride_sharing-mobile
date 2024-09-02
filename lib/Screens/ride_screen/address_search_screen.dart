import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/Controller/ride/adrresse_controller.dart';
import 'package:ride_sharing/models/adress.dart'; // Import the address model

///
/// This is the class for the address search screen.
/// Author: Ictu3091081
/// Created at: August 2024
///
class AddressSearchScreen extends StatefulWidget {
  @override
  _AddressSearchScreenState createState() => _AddressSearchScreenState();
}

class _AddressSearchScreenState extends State<AddressSearchScreen> {
  // Controller for handling the text input in the search field
  final _searchController = TextEditingController();

  // Instance of AddressController for handling address-related operations
  final AddressController _addressController = AddressController();

  // List to hold the search results
  List<Address> _addresses = [];

  // Flag to show/hide loading indicator
  bool _isLoading = false;

  ///
  /// Performs the address search based on the text input.
  /// Updates the state to show loading indicator while fetching data,
  /// and handles errors by showing a snackbar.
  ///
  void _searchAddresses() async {
    final query = _searchController.text;
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Fetch addresses matching the search query
      final addresses = await _addressController.searchAddresses(query);
      setState(() {
        _addresses = addresses; // Update the list of addresses
      });
    } catch (e) {
      // Show an error message if there's an exception during the search
      Get.snackbar(
        'Error',
        'Error: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      // Hide the loading indicator after the search is complete
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Address')), // Title of the search screen
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the search form
        child: Column(
          children: [
            TextField(
              controller: _searchController, // Controller for the search field
              decoration: InputDecoration(
                labelText: 'Search Address', // Label for the search field
                suffixIcon: IconButton(
                  icon: Icon(Icons.search), // Search icon
                  onPressed: _searchAddresses, // Call _searchAddresses when icon is pressed
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  _searchAddresses(); // Perform search when text changes
                } else {
                  setState(() {
                    _addresses = []; // Clear the addresses list if the search field is empty
                  });
                }
              },
            ),
            if (_isLoading)
              Center(child: CircularProgressIndicator()) // Show loading spinner while fetching
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _addresses.length, // Number of items in the list
                  itemBuilder: (context, index) {
                    final address = _addresses[index];
                    return ListTile(
                      title: Text(address.description), // Display address description
                      onTap: () {
                        Get.back(result: address); // Return the selected address
                      },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
