import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisperverse_app/firebase_repository/bookdatabase.dart';
import 'package:whisperverse_app/stories/storymodel.dart';

class Firebaseprovider extends AsyncNotifier<List<Book>> {
  int _current = 0;
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
final viewedbooksprovider = FutureProvider<List<String>>((ref) {
  return ref.read(bookServiceProvider).getViewedIds();
});
final bookmarkedprovider = FutureProvider<List<QueryDocumentSnapshot>>((ref) {
  return ref.read(bookServiceProvider).getAllBookmarks();
});
