class Feedbacks {
  final int id;
  final String comments;
  final int rating;
  final DateTime timestamp;

  Feedbacks({
    required this.id,
    required this.comments,
    required this.rating,
    required this.timestamp,
  });

  factory Feedbacks.fromJson(Map<String, dynamic> json) {
    return Feedbacks(
      id: json['id'],
      comments: json['comments'],
      rating: json['rating'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
