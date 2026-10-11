import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whisperverse_app/stories/chaptermodel.dart';
import 'package:whisperverse_app/stories/storymodel.dart';

class BookService {
  List<Book> books = [];
  final _db = FirebaseFirestore.instance.collection("Storybooks");

  // Get all books (for the home screen)
  Future<List<Book>> getBooks() async {
    streamBooks();
    books.clear();
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("Storybooks")
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
        .collection('chapters')
        .orderBy('chapter')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();

      return Chapter(
        title: data['title'] as String? ?? '',

        chapterNumber: (data['chapter'] as num?)?.toInt() ?? 0,
        pages: data["pages"],
      );
    }).toList();
  }
}
