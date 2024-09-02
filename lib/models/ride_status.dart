class RideStatus {
  final String status;

  RideStatus({required this.status});

  Map<String, dynamic> toJson() => {
    'status': status,
  };

  factory RideStatus.fromJson(Map<String, dynamic> json) => RideStatus(
    status: json['status'],
  );
}
