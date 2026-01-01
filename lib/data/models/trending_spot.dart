class TrendingSpot {
  final String id;
  final String name;
  final String imageUrl;
  final String location;
  final String rating;
  final List<String> tags;
  final String socialProof; // e.g., "Viral on TikTok", "10k Saves"
  final String category; // e.g., "Food", "Experience", "Stay"
  final bool isVideo; // To simulate video content

  TrendingSpot({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.location,
    required this.rating,
    required this.tags,
    required this.socialProof,
    required this.category,
    this.isVideo = false,
  });

  factory TrendingSpot.fromJson(Map<String, dynamic> json) {
    return TrendingSpot(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      location: json['location'],
      rating: json['rating'],
      tags: List<String>.from(json['tags']),
      socialProof: json['socialProof'],
      category: json['category'],
      isVideo: json['isVideo'] ?? false,
    );
  }
}
