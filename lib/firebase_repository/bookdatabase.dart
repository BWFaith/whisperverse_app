import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whisperverse_app/stories/chaptermodel.dart';
import 'package:whisperverse_app/stories/storymodel.dart';

class BookService {
  List<Book> books = [];
  final _db = FirebaseFirestore.instance.collection("StoryBooks");

  // Get all books (for the home screen)
  Future<List<Book>> getBooks() async {
    streamBooks();
    books.clear();
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("StoryBooks")
        .get();

    return snapshot.docs.map((doc) {
      return Book.fromMap({
        ...doc.data() as Map<String, dynamic>,
        'uid': doc.id,
      });
    }).toList();
  }

  Stream<List<Book>> streamBooks() {
    return _db.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Book.fromMap({...doc.data(), 'uid': doc.id});
      }).toList();
    });
  }

  // Get the chapters of ONE book (for the reading screen)
  Future<List<Chapter>> getChapters(String bookId) async {
    final snapshot = await _db
        .doc(bookId)
        .collection('chapter')
        .orderBy('chapterNumber')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();

      return Chapter(
        title: data['title'] as String? ?? '',

        chapterNumber: (data['chapterNumber'] as num?)?.toInt() ?? 0,
        pages: List<String>.from(data['pages'] ?? []),
      );
    }).toList();
  }

  Future<void> saveBookmark(
    String bookId,
    int chapterIndex,
    int pageIndex,
    double progress,
  ) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('progress')
        .doc(bookId)
        .set({
          'chapterIndex': chapterIndex,
          'pageIndex': pageIndex,
          'progress': progress,
          'updatedAt': FieldValue.serverTimestamp(),
        });
  }

  Future<DocumentSnapshot> getBookmark(String bookId) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    getBookmarkStream(bookId);
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('progress')
        .doc(bookId)
        .get();
  }

  Stream<DocumentSnapshot> getBookmarkStream(String bookId) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('progress')
        .doc(bookId)
        .snapshots();
  }

  Future<List<QueryDocumentSnapshot>> getAllBookmarks() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('progress')
        .orderBy('updatedAt', descending: true)
        .get();

    return snapshot.docs;
  }

  Stream<List<QueryDocumentSnapshot>> getAllBookmarksStream() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('progress')
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  Future<void> saveViewed(String bookId) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('viewed')
        .doc(bookId)
        .set({'viewedAt': FieldValue.serverTimestamp()});
  }

  Stream<List<String>> getViewedIds() {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final snapshot = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('viewed')
        .orderBy('viewedAt', descending: true)
        .limit(10)
        .snapshots();

    return snapshot.map((querySnapshot) {
      return querySnapshot.docs.map((doc) => doc.id).toList();
    });
  }
}

class ViewService {
  final _db = FirebaseFirestore.instance;

  Future<void> registerView(String bookId) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return; // not signed in, don't count

    final viewedRef = _db
        .collection('users')
        .doc(uid)
        .collection('viewedBooks')
        .doc(bookId);

    final bookRef = _db.collection('StoryBooks').doc(bookId);

    await _db.runTransaction((tx) async {
      final viewedDoc = await tx.get(viewedRef);
      if (viewedDoc.exists) return; // already counted for this user

      tx.set(viewedRef, {'viewedAt': FieldValue.serverTimestamp()});
      tx.update(bookRef, {'viewCount': FieldValue.increment(1)});
    });
  }
}
