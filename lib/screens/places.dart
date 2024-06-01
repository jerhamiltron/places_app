import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places_app/models/place.dart';
import 'package:places_app/screens/new_place.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key, required this.mainContext});

  final BuildContext mainContext;

  @override
  State<PlacesScreen> createState() => _PlacesState();
}

class _PlacesState extends State<PlacesScreen> {
  List<Place> _places = [];

  void _addPlace() async {
    final newPlace = await Navigator.of(context).push<Place>(
      MaterialPageRoute(
        builder: (context) => const NewPlace(),
      ),
    );

    if (newPlace == null) return;

    setState(() {
      _places.add(newPlace);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text(
        'No places yet...',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    if (_places.isNotEmpty) {
      content = ListView.builder(
        itemCount: _places.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(_places[index].id),
          onDismissed: (dir) {
            print(dir);
          },
          child: ListTile(
            title: Text(_places[index].title),
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        backgroundColor: Theme.of(widget.mainContext).colorScheme.onSurface,
        actions: [
          IconButton(
            onPressed: () {
              _addPlace();
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: content,
    );
  }
}
