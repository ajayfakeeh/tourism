import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:location/data/models/itinerary_model.dart';
import 'package:flutter/foundation.dart';

class GeminiService {
  late GenerativeModel _model;

  // TODO: Replace with your actual API key or use dependency injection to provide it safely
  static const String _apiKey = 'AIzaSyAgliE5tm8Pg59Kv8v0J88PTfTj8RTOngE';

  // Priority list of models to try
  static const List<String> _modelPriorityList = [
    'gemini-2.5-flash',
    'gemini-1.5-pro',
    'gemini-1.0-pro',
    'gemini-pro',
  ];

  GeminiService() {
    // Initialize with the primary model
    _model = GenerativeModel(model: _modelPriorityList.first, apiKey: _apiKey);
  }

  Future<Itinerary> generateItinerary({
    required String destination,
    required int days,
    required List<String> interests,
  }) async {
    final prompt =
        '''
      Act as a professional travel agent. Create a $days-day itinerary for a trip to $destination.
      The traveler is interested in: ${interests.join(', ')}.
      
      Return the response ONLY as a JSON object with the following structure:
      {
        "title": "A descriptive title for the trip",
        "days": [
          {
            "day": 1,
            "activities": [
              {
                "time": "09:00",
                "title": "Activity Title",
                "description": "Short description of what to do",
                "location": "Name of the place"
              }
            ]
          }
        ]
      }
      Do not include any markdown formatting or code blocks. Just the raw JSON string.
    ''';

    // Try generating content with fallback logic
    for (final modelName in _modelPriorityList) {
      try {
        if (kDebugMode) {
          print('Attempting to generate itinerary using model: $modelName');
        }

        // Update the model instance to the current one in the loop
        _model = GenerativeModel(model: modelName, apiKey: _apiKey);

        final content = [Content.text(prompt)];
        final response = await _model.generateContent(content);

        if (response.text == null) {
          throw Exception('No response from AI');
        }

        final jsonString = _cleanJson(response.text!);
        final jsonData = jsonDecode(jsonString);

        if (kDebugMode) {
          print('Successfully generated itinerary using model: $modelName');
        }

        return Itinerary.fromJson(jsonData);
      } catch (e) {
        if (kDebugMode) {
          print('Failed with model $modelName: $e');
        }
        // If this was the last model in the list, rethrow the error
        if (modelName == _modelPriorityList.last) {
          rethrow;
        }
        // Otherwise continue to the next model
        continue;
      }
    }

    throw Exception('All models failed to generate itinerary');
  }

  String _cleanJson(String text) {
    // Remove code block markers if present
    return text.replaceAll('```json', '').replaceAll('```', '').trim();
  }
}
