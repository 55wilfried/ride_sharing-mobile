class Address {
  final String id;
  final String description;
  final String placeId;

  Address({
    required this.id,
    required this.description,
    required this.placeId,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      description: json['description'],
      placeId: json['place_id'],
    );
  }
}
