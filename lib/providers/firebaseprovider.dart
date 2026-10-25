import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisperverse_app/firebase_repository/bookdatabase.dart';
import 'package:whisperverse_app/stories/storymodel.dart';

class Firebaseprovider extends AsyncNotifier<List<Book>> {
  final int _current = 0;
  Timer? _timer;

  @override
  Future<List<Book>> build() {
    throw UnimplementedError();
  }
}

final bookServiceProvider = Provider((ref) => BookService());
final allbooksprovider = FutureProvider<List<Book>>((ref) {
  return ref.read(bookServiceProvider).getBooks();
});
final viewedbooksprovider = StreamProvider<List<String>>((ref) {
  return ref.read(bookServiceProvider).getViewedIds();
});
final bookmarkedprovider = FutureProvider<List<QueryDocumentSnapshot>>((ref) {
  return ref.read(bookServiceProvider).getAllBookmarks();
});
final bookmarksStreamProvider = StreamProvider<List<QueryDocumentSnapshot>>((
  ref,
) {
  return ref.read(bookServiceProvider).getAllBookmarksStream();
});

final userProfileProvider = StreamProvider<Map<String, dynamic>?>((ref) {
  return FirebaseAuth.instance.authStateChanges().asyncExpand((user) {
    if (user == null) return Stream.value(null);
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .map((doc) => doc.data());
  });
});
