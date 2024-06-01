import 'package:flutter/material.dart';
import 'package:places_app/models/place.dart';

class NewPlace extends StatefulWidget {
  const NewPlace({super.key});

  @override
  State<NewPlace> createState() => _NewPlaceState();
}

class _NewPlaceState extends State<NewPlace> {
  final _formKey = GlobalKey<FormState>();
  var _inProgress = false;

  var _enteredTitle = '';

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // setState(() {
      //   _inProgress = true;
      // });

      Navigator.of(context).pop(
        Place(
          id: 'a',
          title: _enteredTitle,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              maxLength: 50,
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
            const SizedBox(height: 64),
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
                ElevatedButton(
                  onPressed: _inProgress ? null : _saveItem,
                  child: _inProgress
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(),
                        )
                      : const Text('Add Item'),
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
      ),
      body: content,
    );
  }
}
