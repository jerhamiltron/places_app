import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places_app/models/place.dart';
import 'package:places_app/providers/places_provider.dart';

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
            title: Text(
              places[index].title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            leading: Container(
              height: 12,
              width: 12,
              alignment: Alignment.center,
              child: Text('${index + 1}'),
            ),
          ),
        ),
      );
    }

    return content;
  }
}
