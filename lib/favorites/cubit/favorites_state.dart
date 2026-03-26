part of 'favorites_cubit.dart';

class FavoritesState {
  final List<String> favoriteIds;

  const FavoritesState({this.favoriteIds = const []});

  bool isFavorite(String id) => favoriteIds.contains(id);

  FavoritesState copyWith({List<String>? favoriteIds}) {
    return FavoritesState(
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }
}
