import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesState();
}

class _PlacesState extends State<PlacesScreen> {
  void _addPlace() {
    print('Adding a place...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          IconButton(
            onPressed: () {
              _addPlace();
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
