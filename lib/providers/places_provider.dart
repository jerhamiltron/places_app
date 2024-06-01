import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places_app/models/place.dart';

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super([]);

  final List<Place> places = [];

  bool selectFavorite(Place place) {
    final isFavorite = state.contains(place);

    if (isFavorite) {
      state = state.where((p) => p.id != place.id).toList();
      return false;
    } else {
      state = [...state, place];
      return true;
    }
  }
}

final placesProvider =
    StateNotifierProvider<PlacesNotifier, List<Place>>((ref) {
  return PlacesNotifier();
});
