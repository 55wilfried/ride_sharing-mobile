import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:ride_sharing/Screens/Payment/payment_.dart';
import 'package:ride_sharing/Screens/feedback_screen/feedback_screen.dart';
import 'package:ride_sharing/Screens/feedback_screen/view_feedback.dart';
import 'package:ride_sharing/Screens/ride_screen/address_search_screen.dart';
import 'package:ride_sharing/Screens/ride_screen/ride_request_screen.dart';

///
/// This is the class for the map screen where users can see pickup and dropoff locations on Google Maps.
/// Author: Ictu3091081
/// Created at: August 2024
///
class MapScreen extends StatefulWidget {
  // Addresses for pickup and dropoff locations passed to this screen
  final String pickupAddress;
  final String dropoffAddress;

  // Constructor for initializing the screen with pickup and dropoff addresses
  MapScreen({required this.pickupAddress, required this.dropoffAddress});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Google Map controller instance for controlling the map
  late GoogleMapController _mapController;
  // Default locations for pickup and dropoff
  LatLng _pickupLocation = LatLng(37.7749, -122.4194);
  LatLng _dropoffLocation = LatLng(37.7749, -122.4194);

  @override
  void initState() {
    super.initState();
    _getCoordinates(); // Fetch coordinates for the given addresses
  }

  ///
  /// Called when the Google Map has been created. Initializes the map controller.
  ///
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _updateLocation(); // Update the map view to fit the locations
  }

  ///
  /// Updates the map view to include both pickup and dropoff locations.
  ///
  void _updateLocation() {
    final bounds = LatLngBounds(
      southwest: LatLng(
        min(_pickupLocation.latitude, _dropoffLocation.latitude),
        min(_pickupLocation.longitude, _dropoffLocation.longitude),
      ),
      northeast: LatLng(
        max(_pickupLocation.latitude, _dropoffLocation.latitude),
        max(_pickupLocation.longitude, _dropoffLocation.longitude),
      ),
    );

    _mapController.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50.0),
    );
  }

  ///
  /// Fetches coordinates for pickup and dropoff addresses using the geocoding API.
  /// Updates the map with the new locations.
  ///
  Future<void> _getCoordinates() async {
    try {
      List<geocoding.Location> pickupLocations = await geocoding.locationFromAddress(widget.pickupAddress);
      List<geocoding.Location> dropoffLocations = await geocoding.locationFromAddress(widget.dropoffAddress);

      if (pickupLocations.isNotEmpty && dropoffLocations.isNotEmpty) {
        setState(() {
          _pickupLocation = LatLng(pickupLocations.first.latitude, pickupLocations.first.longitude);
          _dropoffLocation = LatLng(dropoffLocations.first.latitude, dropoffLocations.first.longitude);
        });
        _updateLocation(); // Update map view with new coordinates
      } else {
        print('No locations found for the given addresses.');
      }
    } catch (e) {
      print('Error getting coordinates: $e'); // Log error if geocoding fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'), // Title of the map screen
      ),
      body: Stack(
        children: [
          // Google Map widget displaying pickup and dropoff locations
          Positioned.fill(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _pickupLocation,
                zoom: 12.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('pickup_location'),
                  position: _pickupLocation,
                  infoWindow: InfoWindow(title: 'Pickup Location'),
                ),
                Marker(
                  markerId: MarkerId('dropoff_location'),
                  position: _dropoffLocation,
                  infoWindow: InfoWindow(title: 'Dropoff Location'),
                ),
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            // Drawer item for navigating to the Ride Request screen
            _buildDrawerItem(
              icon: Icons.directions_car,
              title: 'Ride',
              onTap: () {
                Get.to(() => RideRequestScreen());
              },
            ),
            // Drawer item for navigating to the Payment screen
            _buildDrawerItem(
              icon: Icons.payment,
              title: 'Payment',
              onTap: () {
                Get.to(() => PaymentScreen());
              },
            ),
            // Drawer item for navigating to the Feedback screen
            _buildDrawerItem(
              icon: Icons.feedback,
              title: 'Feedback',
              onTap: () {
                Get.to(() => FeedbackScreen());
              },
            ),
            // Drawer item for navigating to the View Feedback screen
            _buildDrawerItem(
              icon: Icons.view_list,
              title: 'View Feedback',
              onTap: () {
                Get.to(() => ViewFeedbackScreen());
              },
            ),
            // Drawer item for navigating to the Address Search screen
            _buildDrawerItem(
              icon: Icons.search,
              title: 'Search',
              onTap: () {
                Get.to(() => AddressSearchScreen());
              },
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// Builds a drawer item with an icon, title, and tap handler.
  ///
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap, // Action when item is tapped
    );
  }
}
