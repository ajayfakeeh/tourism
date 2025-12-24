import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String userName;
  final double rating;
  final String comment;

  const Review({
    required this.userName,
    required this.rating,
    required this.comment,
  });

  @override
  List<Object?> get props => [userName, rating, comment];

  Map<String, dynamic> toJson() {
    return {'userName': userName, 'rating': rating, 'comment': comment};
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      userName: json['userName'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      comment: json['comment'] ?? '',
    );
  }
}
