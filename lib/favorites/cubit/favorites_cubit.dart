import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesState());

  void toggleFavorite(String flightId) {
    final current = List<String>.from(state.favoriteIds);
    if (current.contains(flightId)) {
      current.remove(flightId);
    } else {
      current.add(flightId);
    }
    emit(state.copyWith(favoriteIds: current));
  }

  bool isFavorite(String flightId) => state.isFavorite(flightId);
}
