import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:places_app/models/place.dart';
// import 'package:places_app/providers/places_provider.dart';
import 'package:places_app/screens/new_place.dart';
import 'package:places_app/widgets/places_list.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() => _PlacesState();
}

class _PlacesState extends ConsumerState<PlacesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const NewPlace(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        child: PlacesList(),
      ),
    );
  }
}
