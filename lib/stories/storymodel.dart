import 'package:whisperverse_app/stories/chaptermodel.dart';

class Book {
  final String uid;
  final String title;
  final String author;
  final String description;
  final String coverImage;
  final String category;
  final List<Chapter> chapter;
  final int totalPages;
  final bool isFeatured;
  final int viewCount;

  Book({
    required this.uid,
    required this.title,
    required this.author,
    required this.description,
    required this.coverImage,
    required this.category,
    this.chapter = const [],
    required this.totalPages,
    this.isFeatured = false,
    this.viewCount = 0,
  });

  Book copyWith({bool? isFavorite}) {
    return Book(
      uid: uid,
      title: title,
      author: author,
      description: description,
      coverImage: coverImage,
      category: category,
      chapter: chapter,
      totalPages: totalPages,
    );
  }

  static Map<String, Object?> toMap(Book book) {
    return {
      "uid": book.uid,
      "title": book.title,
      "author": book.author,
      "description": book.description,
      "coverImage": book.coverImage,
      "category": book.category,
      "totalpage": book.totalPages,
      "isFeatured": book.isFeatured,
      "viewCount": book.viewCount,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      uid: map["uid"] ?? '',
      title: map["title"] ?? '',
      author: map["author"] ?? '',
      description: map["description"] ?? '',
      coverImage: map["coverImage"] ?? '',
      category: map["category"] ?? 'Uncategorized',
      totalPages: map["totalpage"] ?? 0,
      isFeatured: map["isFeatured"] ?? false,
      viewCount: map["viewCount"] ?? 0,
    );
  }
}
