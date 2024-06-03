import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places_app/models/place.dart';
import 'package:places_app/providers/places_provider.dart';
import 'package:places_app/screens/place_detail.dart';

class PlacesList extends ConsumerWidget {
  const PlacesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Place> places = ref.watch(placesProvider);

    Widget content = Center(
      child: Text(
        'No places yet...',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
    );

    if (places.isNotEmpty) {
      content = ListView.builder(
        itemCount: places.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(places[index].id),
          onDismissed: (dir) =>
              ref.read(placesProvider.notifier).removePlace(places[index]),
          child: ListTile(
            minTileHeight: 60,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => PlaceDetailScreen(
                    place: places[index],
                  ),
                ),
              );
            },
            titleAlignment: ListTileTitleAlignment.center,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  places[index].title,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
                Text(
                  places[index].location.address,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                )
              ],
            ),
            leading: CircleAvatar(
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerLowest,
              radius: 27,
              child: SizedBox(
                height: 48,
                width: 48,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  child: Image.file(File(places[index].image!.path),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return content;
  }
}
