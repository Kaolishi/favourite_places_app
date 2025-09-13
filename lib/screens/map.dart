import 'package:favourite_places_app/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Interactive Google Maps screen for location selection or viewing
/// Can be used in two modes: selecting a location or viewing an existing one
class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 37.422, // Default: Google HQ coordinates
      longitude: -122.084,
      address: '',
    ),
    this.isSelecting = true,
  });

  final PlaceLocation location; // Initial location to display
  final bool isSelecting; // True for selection mode, false for view-only

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation; // User-selected location

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isSelecting ? 'Pick Your Location' : 'Your location',
        ),
        actions: [
          // Save button only appears in selection mode
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                // Return selected location to calling screen
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: const Icon(Icons.save),
            ),
        ],
      ),
      body: GoogleMap(
        // Handle tap events to select location
        onTap: widget.isSelecting
            ? (position) {
                setState(() {
                  _pickedLocation = position;
                });
              }
            : null,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.location.latitude, widget.location.longitude),
          zoom: 16,
        ),
        // Show marker for picked location or provided location
        markers: (_pickedLocation == null && widget.isSelecting)
            ? {} // No marker until user picks a location
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position:
                      _pickedLocation ?? // Use picked location if available
                      LatLng(
                        widget.location.latitude,
                        widget.location.longitude,
                      ),
                ),
              },
      ),
    );
  }
}
