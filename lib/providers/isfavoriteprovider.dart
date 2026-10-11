import 'package:flutter_riverpod/legacy.dart';
import 'package:whisperverse_app/stories/storymodel.dart';

// @immutable
// class Pagemodel {
//   const Pagemodel({
//     this.chapter,
//     this.title,
//     this.longtext,
//     required this.isFavorite,
//   });

//   final String? chapter;
//   final String? title;
//   final String? longtext;
//   final bool isFavorite;
// }

class Isfavoriteprovider extends StateNotifier<List<Book>> {
  Isfavoriteprovider() : super([]);
  void toggleFavorite(Book book) {
    final alreadyFavorite = state.any((b) => b.uid == book.uid);

    if (alreadyFavorite) {
      state = state.where((b) => b.uid != book.uid).toList();
    } else {
      state = [...state, book];
    }
  }
}

//   void addFavorite(Book book) {
//     state = [...state, book];
//   }

//   void removeFavorite(Book book) {
//     state = state.where((e) => e != book).toList();
//   }
// }

final favoriteProvider = StateNotifierProvider<Isfavoriteprovider, List<Book>>((
  ref,
) {
  return Isfavoriteprovider();
});
