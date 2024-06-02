import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:places_app/models/place.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.setLocation});

  final void Function(PlaceLocation location) setLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _location;
  var _gettingLocation = false;

  String get locationImage {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=${_location!.latitude},${_location!.longitude}&zoom=14&size=400x400&key=${'AIzaSyB-56jgjLgeIzzmsVZRcM8LzZg4KdBZXuk'}';
  }

  void _getLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (serviceEnabled) return;
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    setState(() {
      _gettingLocation = true;
    });

    locationData = await location.getLocation();

    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${locationData.latitude},${locationData.longitude}&key=${'AIzaSyB-56jgjLgeIzzmsVZRcM8LzZg4KdBZXuk'}');
    final res = await http.get(url);
    final resData = json.decode(res.body);
    final address = resData['results'][0]['formatted_address'];

    var lat = locationData.latitude;
    var lng = locationData.longitude;

    if (lat == null || lng == null) return;

    setState(() {
      _location =
          PlaceLocation(latitude: lat, longitude: lng, address: address);
      _gettingLocation = false;
    });

    if (_location != null) {
      widget.setLocation(
        PlaceLocation(
          latitude: locationData.latitude!,
          longitude: locationData.longitude!,
          address: address,
        ),
      );
    }
  }

  void _pickLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (serviceEnabled) return;
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    locationData = await location.getLocation();

    final url = Uri.parse(
        'https://maps.googleapis.come/maps/api/geocode/json?latlng=${locationData.latitude},${locationData.longitude}&key=${'AIzaSyB-56jgjLgeIzzmsVZRcM8LzZg4KdBZXuk'}');
    final res = await http.get(url);
    final resData = json.decode(res.body);
    final address = resData['results'][0]['formatted_address'];

    var lat = locationData.latitude;
    var lng = locationData.longitude;

    if (lat == null || lng == null) return;

    setState(() {
      _location =
          PlaceLocation(latitude: lat, longitude: lng, address: address);
    });

    if (_location != null) {
      widget.setLocation(
        PlaceLocation(
          latitude: locationData.latitude!,
          longitude: locationData.longitude!,
          address: address,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget mapContent = Text(
      'No Location Chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
    );

    if (_location != null && !_gettingLocation) {
      // mapContent = Padding(
      //   padding: const EdgeInsets.all(24),
      //   child: Text(
      //     _location!.address,
      //     softWrap: true,
      //     maxLines: 3,
      //     textAlign: TextAlign.center,
      //     style: Theme.of(context).textTheme.bodyLarge!.copyWith(
      //           color: Theme.of(context).colorScheme.onSurface,
      //         ),
      //   ),
      // );

      mapContent = ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(48)),
        child: Image.network(
          locationImage,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      );
    }

    if (_gettingLocation) {
      mapContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(48)),
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          child: mapContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Get Current Location'),
              onPressed: _getLocation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Select on Map'),
              onPressed: _pickLocation,
            )
          ],
        ),
      ],
    );
  }
}
