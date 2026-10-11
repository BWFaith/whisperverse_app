class BookPage {
  final int pageNumber;
  final String content;
  final String? imageUrl; // Optional, in case a page has an illustration

  BookPage({required this.pageNumber, required this.content, this.imageUrl});
}
