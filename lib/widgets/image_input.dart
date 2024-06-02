import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.setImage});

  final Function(XFile image) setImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  XFile? _takenImage;

  void _takePicture() async {
    final ImagePicker picker = ImagePicker();
    // final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) {
      return;
    }

    // set image inside new place screen
    setState(() {
      _takenImage = image;
    });

    // set image in new place screen to save to data
    widget.setImage(image);
  }

  void _removePicture() {
    setState(() {
      _takenImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(48)),
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: TextButton.icon(
        icon: const Icon(Icons.camera),
        label: const Text('Take Image'),
        onPressed: _takePicture,
      ),
    );

    if (_takenImage != null) {
      content = Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(48)),
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            child: GestureDetector(
              onTap: _takePicture,
              onLongPress: _removePicture,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(48),
                child: Image.file(File(_takenImage!.path), fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Column(
            children: [
              Text(
                'Tap again to take another image.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              Text(
                'Long press to reset',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
            ],
          )
        ],
      );
    }

    return content;
  }
}
