import 'package:favourite_places_app/models/place.dart';
import 'package:favourite_places_app/screens/place_detail.dart';
import 'package:flutter/material.dart';

/// Widget that displays a scrollable list of favorite places
/// Shows empty state message when no places exist
class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    // Show empty state when no places added yet
    if (places.isEmpty) {
      return Center(
        child: Text(
          'Wow, such empty...',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      );
    }

    // Build scrollable list of places
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          // Circular image preview
          leading: CircleAvatar(
            radius: 26,
            backgroundImage: FileImage(places[index].image),
          ),
          // Place title
          title: Text(
            places[index].title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          // Place address as subtitle
          subtitle: Text(
            places[index].location.address,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          // Navigate to detail screen on tap
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PlaceDetailScreen(
                  place: places[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
