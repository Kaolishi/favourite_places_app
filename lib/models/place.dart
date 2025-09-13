import 'dart:io';

import 'package:uuid/uuid.dart';

// UUID generator for creating unique place IDs
var uuid = const Uuid();

/// Represents a geographic location with coordinates and human-readable address
class PlaceLocation {
  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  final double latitude;
  final double longitude;
  final String address; // Human-readable address from Google Geocoding API
}

/// Represents a favorite place with title, image, location, and unique ID
class Place {
  Place({
    required this.title,
    required this.image,
    required this.location,
    String? id, // Optional ID for database operations
  }) : id = id ?? uuid.v4(); // Generate UUID if not provided

  final String id; // Unique identifier for the place
  final String title;
  final File image; // Captured image file
  final PlaceLocation location;
}
