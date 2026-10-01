class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final String coverImage;
  final String category;
  final List<String> pages;
  final int totalPages;
  final bool isFeatured;

  final int readCount;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.coverImage,
    required this.category,
    required this.pages,
    required this.totalPages,
    this.isFeatured = false,
    this.readCount = 0,
  });
}
