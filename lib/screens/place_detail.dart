import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places_app/models/place.dart';
import 'package:places_app/screens/map.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key, required this.place});

  final Place place;

  String get locationImage {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=${place.location.latitude},${place.location.longitude}&zoom=14&size=400x400&maptype=roadmap&markers=color:red%Clabel:A%7C${place.location.latitude},${place.location.longitude}&key=${'AIzaSyB-56jgjLgeIzzmsVZRcM8LzZg4KdBZXuk'}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      ),
      body: Stack(
        children: [
          Image.file(
            File(place.image!.path),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => MapScreen(
                          location: place.location,
                          isSelecting: false,
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 84,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(84)),
                      child: Image.network(locationImage, fit: BoxFit.cover),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  height: 150,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black87],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Text(
                    place.location.address,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // Body prior to video
      // *******************
      // body: Center(
      //   child: Padding(
      //     padding: const EdgeInsets.all(16),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Text(
      //           'Address:',
      //           style: Theme.of(context).textTheme.labelMedium!.copyWith(
      //               color: Theme.of(context).colorScheme.primary, fontSize: 16),
      //         ),
      //         Text(
      //           place.location.address,
      //           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
      //               color: Theme.of(context).colorScheme.onSurface,
      //               fontSize: 20),
      //           textAlign: TextAlign.center,
      //         ),
      //         const SizedBox(height: 24),
      //         SizedBox(
      //           height: 350,
      //           width: 400,
      //           child: ClipRRect(
      //             borderRadius: const BorderRadius.only(
      //               topLeft: Radius.circular(16),
      //               topRight: Radius.circular(16),
      //             ),
      //             child: Image.file(
      //               File(place.image!.path),
      //               fit: BoxFit.cover,
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 200,
      //           width: 400,
      //           child: ClipRRect(
      //             borderRadius: const BorderRadius.only(
      //               bottomLeft: Radius.circular(16),
      //               bottomRight: Radius.circular(16),
      //             ),
      //             child: Image.network(
      //               locationImage,
      //               fit: BoxFit.cover,
      //               width: double.infinity,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
