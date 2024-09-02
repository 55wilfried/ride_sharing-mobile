class RideRequest {
  final String pickupLocation;
  final String dropoffLocation;

  RideRequest({required this.pickupLocation, required this.dropoffLocation});

  Map<String, dynamic> toJson() => {
    'pickupLocation': pickupLocation,
    'dropoffLocation': dropoffLocation,
  };

  factory RideRequest.fromJson(Map<String, dynamic> json) => RideRequest(
    pickupLocation: json['pickupLocation'],
    dropoffLocation: json['dropoffLocation'],
  );
}
