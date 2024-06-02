import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:places_app/models/place.dart';
import 'package:places_app/providers/places_provider.dart';
import 'package:places_app/widgets/image_input.dart';

class NewPlace extends ConsumerStatefulWidget {
  const NewPlace({super.key});

  @override
  ConsumerState<NewPlace> createState() => _NewPlaceState();
}

class _NewPlaceState extends ConsumerState<NewPlace> {
  final _formKey = GlobalKey<FormState>();
  var _inProgress = false;

  var _enteredTitle = '';
  late XFile _enteredImage;

  void _savePlace() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ref
          .read(placesProvider.notifier)
          .addPlace(Place(title: _enteredTitle, image: _enteredImage));

      Navigator.of(context).pop();
    }
  }

  void _setImage(XFile file) {
    setState(() {
      _enteredImage = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              maxLength: 50,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.trim().length <= 1 ||
                    value.trim().length > 50) {
                  return 'Must be between 1 and 50 characters';
                }
                return null;
              },
              onSaved: (value) {
                _enteredTitle = value!;
              },
            ),
            const SizedBox(height: 24),
            ImageInput(setImage: _setImage),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _inProgress
                      ? null
                      : () {
                          _formKey.currentState!.reset();
                        },
                  child: const Text('Reset'),
                ),
                ElevatedButton.icon(
                  onPressed: _inProgress ? null : _savePlace,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Place'),
                )
              ],
            )
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new place'),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      ),
      body: content,
    );
  }
}
