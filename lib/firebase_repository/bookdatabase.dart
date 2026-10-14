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

  Future<DocumentSnapshot> getBookmark(String bookId) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('progress')
        .doc(bookId)
        .get();
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
}
