class Itinerary {
  final String title;
  final List<ItineraryDay> days;

  Itinerary({required this.title, required this.days});

  factory Itinerary.fromJson(Map<String, dynamic> json) {
    return Itinerary(
      title: json['title'] ?? 'My Trip',
      days: (json['days'] as List<dynamic>)
          .map((e) => ItineraryDay.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ItineraryDay {
  final int dayNumber;
  final List<Activity> activities;

  ItineraryDay({required this.dayNumber, required this.activities});

  factory ItineraryDay.fromJson(Map<String, dynamic> json) {
    return ItineraryDay(
      dayNumber: json['day'] as int,
      activities: (json['activities'] as List<dynamic>)
          .map((e) => Activity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Activity {
  final String time;
  final String title;
  final String description;
  final String location;

  Activity({
    required this.time,
    required this.title,
    required this.description,
    required this.location,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      time: json['time'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
    );
  }
}
