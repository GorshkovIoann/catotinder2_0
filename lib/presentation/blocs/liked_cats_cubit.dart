import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/liked_cat.dart';

class LikedCatsState {
  final List<LikedCat> allLikedCats;
  final String filter; // Фильтр по породе

  LikedCatsState({required this.allLikedCats, required this.filter});

  List<LikedCat> get filteredCats {
    if (filter.isEmpty) return allLikedCats;
    return allLikedCats.where((likedCat) {
      return likedCat.cat.breedName.toLowerCase().contains(
        filter.toLowerCase(),
      );
    }).toList();
  }

  LikedCatsState copyWith({List<LikedCat>? allLikedCats, String? filter}) {
    return LikedCatsState(
      allLikedCats: allLikedCats ?? this.allLikedCats,
      filter: filter ?? this.filter,
    );
  }
}

class LikedCatsCubit extends Cubit<LikedCatsState> {
  LikedCatsCubit() : super(LikedCatsState(allLikedCats: [], filter: ''));

  void addLikedCat(LikedCat likedCat) {
    final newList = List<LikedCat>.from(state.allLikedCats)..add(likedCat);
    emit(state.copyWith(allLikedCats: newList));
  }

  void removeLikedCat(LikedCat likedCat) {
    final newList = List<LikedCat>.from(state.allLikedCats)..remove(likedCat);
    emit(state.copyWith(allLikedCats: newList));
  }

  void setFilter(String filter) {
    emit(state.copyWith(filter: filter));
  }
}
