import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ride_sharing/models/adress.dart'; // Import the model

///
/// This class handles address searches using the Google Places API.
/// Author: Ictu3091081
/// Created at: September 2024
///
class AddressController {
  final String baseUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json'; // Google Places API endpoint
  final String apiKey = 'YOUR_GOOGLE_API_KEY'; // Replace with your actual Google API key

  /// Searches for addresses based on the provided query.
  ///
  /// [query] The search query to be used for finding addresses.
  /// Returns a [Future<List<Address>>] which contains a list of addresses matching the query.
  /// Throws an [Exception] if the request fails.
  Future<List<Address>> searchAddresses(String query) async {
    // Construct the URL with the query and API key
    final response = await http.get(Uri.parse('$baseUrl?input=$query&key=$apiKey'));

    if (response.statusCode == 200) {
      // Parse the JSON response
      final data = json.decode(response.body);

      // Extract the list of predictions from the response
      List<dynamic> predictions = data['predictions'];

      // Map each prediction to an Address object and return the list
      return predictions.map((json) => Address.fromJson(json)).toList();
    } else {
      // Throw an exception if the response status is not 200 OK
      throw Exception('Failed to load addresses');
    }
  }
}
