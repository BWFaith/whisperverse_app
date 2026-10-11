class Chapter {
  final String title;
  final int chapterNumber;
  final List<String> pages; // chapter → pages (just text)

  Chapter({
    required this.title,
    required this.chapterNumber,
    required this.pages,
  });
}
