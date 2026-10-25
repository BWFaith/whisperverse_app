import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:whisperverse_app/firebase_repository/bookdatabase.dart';
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
  Isfavoriteprovider() : super([]) {
    _authSub = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        state = []; // logged out: clear LOCAL list only
      } else {
        _loadFavorites(user.uid); // logged in: reload from Firestore
      }
    });
  }

  final _db = FirebaseFirestore.instance;
  StreamSubscription<User?>? _authSub;

  CollectionReference<Map<String, dynamic>>? get _favRef {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;
    return _db.collection('users').doc(uid).collection('favorites');
  }

  Future<void> _loadFavorites(String uid) async {
    debugPrint('1. loading favorites for $uid');
    try {
      final favSnap = await _db
          .collection('users')
          .doc(uid)
          .collection('favorites')
          .get();

      debugPrint('2. found ${favSnap.docs.length} favorite ids');

      // fetch each favorited book from the books collection
      final bookDocs = await Future.wait(
        favSnap.docs.map((f) => _db.collection('books').doc(f.id).get()),
      );

      final books = bookDocs
          .where((d) => d.exists) // skip books that were deleted
          .map((d) => Book.fromMap({...d.data()!, 'uid': d.id}))
          .toList();

      // ignore the result if a different user logged in meanwhile
      if (FirebaseAuth.instance.currentUser?.uid != uid) return;
      state = books;
    } catch (e) {
      debugPrint('Failed to load favorites: $e');
    }
  }

  Future<void> toggleFavorite(Book book) async {
    final ref = _favRef;
    if (ref == null) return; // not logged in

    final previous = state;
    final alreadyFavorite = state.any((b) => b.uid == book.uid);

    // update the UI instantly, don't wait for the network
    state = alreadyFavorite
        ? state.where((b) => b.uid != book.uid).toList()
        : [...state, book];

    try {
      if (alreadyFavorite) {
        await ref.doc(book.uid).delete();
      } else {
        await ref.doc(book.uid).set({'addedAt': FieldValue.serverTimestamp()});
      }
    } catch (e) {
      state = previous; // save failed: undo the change on screen
      debugPrint('Failed to update favorite: $e');
    }
  }

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }

  // void toggleFavorite(Book book) {
  //   final alreadyFavorite = state.any((b) => b.uid == book.uid);

  //   if (alreadyFavorite) {
  //     state = state.where((b) => b.uid != book.uid).toList();
  //   } else {
  //     state = [...state, book];
  //   }
  // }
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

final favoriteIdsProvider = StreamProvider<Set<String>>((ref) {
  return FirebaseAuth.instance.authStateChanges().asyncExpand((user) {
    if (user == null) return Stream.value(<String>{}); // logged out: empty

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.id).toSet());
  });
});

final allStreamBooksProvider = StreamProvider<List<Book>>((ref) {
  return BookService().streamBooks();
});

final favoriteBooksProvider = Provider<AsyncValue<List<Book>>>((ref) {
  final ids = ref.watch(favoriteIdsProvider);
  final books = ref.watch(allStreamBooksProvider);

  return ids.when(
    data: (idSet) => books.whenData(
      (list) => list.where((b) => idSet.contains(b.uid)).toList(),
    ),
    loading: () => const AsyncLoading<List<Book>>(),
    error: (e, s) => AsyncError<List<Book>>(e, s),
  );
});

final favoriteActionsProvider = Provider((ref) => FavoriteActions());

class FavoriteActions {
  CollectionReference<Map<String, dynamic>>? get _ref {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorites');
  }

  Future<void> toggle(Book book, {required bool isFavorite}) async {
    final ref = _ref;
    if (ref == null) return;

    if (isFavorite) {
      await ref.doc(book.uid).delete();
    } else {
      await ref.doc(book.uid).set({'addedAt': FieldValue.serverTimestamp()});
    }
  }
}
