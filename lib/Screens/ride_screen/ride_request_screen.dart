import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/Screens/ride_screen/address_search_screen.dart';
import 'package:ride_sharing/Screens/ride_screen/confirm_ride_screen.dart';
import 'package:ride_sharing/Screens/ride_screen/map_screen.dart';
import 'package:ride_sharing/models/confirm_ride.dart';

///
/// This screen allows users to request a ride by providing pickup and dropoff addresses.
/// It also provides options to confirm the ride request or view the route on a map.
/// Author: Ictu3091081
/// Created at: August 2024
///
class RideRequestScreen extends StatefulWidget {
  @override
  _RideRequestScreenState createState() => _RideRequestScreenState();
}

class _RideRequestScreenState extends State<RideRequestScreen> {
  final TextEditingController _pickupAddressController = TextEditingController();
  final TextEditingController _dropoffAddressController = TextEditingController();

  String _pickupAddress = '';
  String _dropoffAddress = '';
  double _estimatedFare = 0.0;

  ///
  /// Opens the AddressSearchScreen to select an address and updates the controller with the selected address.
  ///
  Future<void> _selectAddress(TextEditingController controller) async {
    final selectedAddress = await Get.to(() => AddressSearchScreen());

    if (selectedAddress != null) {
      setState(() {
        controller.text = selectedAddress;
        if (controller == _pickupAddressController) {
          _pickupAddress = selectedAddress;
        } else if (controller == _dropoffAddressController) {
          _dropoffAddress = selectedAddress;
        }
        _calculateFare(); // Recalculate fare when address is set
      });
    }
  }

  ///
  /// Calculates the estimated fare. This is a placeholder and should be replaced with actual fare calculation logic.
  ///
  void _calculateFare() {
    setState(() {
      _estimatedFare = 10.0; // Example fare calculation, replace with actual logic
    });
  }

  ///
  /// Navigates to the ConfirmRideScreen if both pickup and dropoff addresses are provided. Shows a snackbar if either address is missing.
  ///
  void _navigateToConfirmRideScreen() {
    if (_pickupAddress.isNotEmpty && _dropoffAddress.isNotEmpty) {
      final rideDetails = RideDetails(
        pickupAddress: _pickupAddress,
        dropoffAddress: _dropoffAddress,
        estimatedFare: _estimatedFare,
      );

      Get.to(() => ConfirmRideScreen(rideDetails: rideDetails));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both pickup and dropoff addresses')),
      );
    }
  }

  ///
  /// Navigates to the MapScreen to view the route on a map if both addresses are provided. Shows a snackbar if either address is missing.
  ///
  void _viewOnMap() {
    if (_pickupAddress.isNotEmpty && _dropoffAddress.isNotEmpty) {
      Get.to(() => MapScreen(
        pickupAddress: _pickupAddress,
        dropoffAddress: _dropoffAddress,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both pickup and dropoff addresses')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Ride'), // Title of the ride request screen
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextField for entering pickup address with a search icon to open address search screen
            TextField(
              controller: _pickupAddressController,
              decoration: InputDecoration(
                labelText: 'Pickup Address',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _selectAddress(_pickupAddressController),
                ),
              ),
            ),
            SizedBox(height: 16),
            // TextField for entering dropoff address with a search icon to open address search screen
            TextField(
              controller: _dropoffAddressController,
              decoration: InputDecoration(
                labelText: 'Dropoff Address',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _selectAddress(_dropoffAddressController),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Display the estimated fare
            Text('Estimated Fare: \$${_estimatedFare.toStringAsFixed(2)}'),
            SizedBox(height: 20),
            // Row containing buttons to confirm the ride request or view it on a map
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _navigateToConfirmRideScreen,
                  child: Text('Confirm Ride Request'),
                ),
                ElevatedButton(
                  onPressed: _viewOnMap,
                  child: Text('View on Map'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
