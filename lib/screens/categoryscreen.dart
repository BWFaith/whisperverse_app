import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/screens/storypages.dart';
import 'package:whisperverse_app/stories/storymodel.dart';
import 'package:whisperverse_app/widgets/storybookcard.dart';

class Categoryscreen extends StatelessWidget {
  const Categoryscreen({
    super.key,
    required this.categoryTitle,
    required this.books,
  });
  final String categoryTitle;
  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    const int crossAxisCount = 3;
    const double crossAxisSpacing = 10.0;

    const double desiredItemHeight = 240.0;

    final double totalSpacing = crossAxisSpacing * (crossAxisCount - 1);
    final double itemWidth = (screenWidth - totalSpacing) / crossAxisCount;

    final double dynamicAspectRatio = itemWidth / desiredItemHeight;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle,
          style: GoogleFonts.fredoka(fontSize: 21, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          clipBehavior: Clip.hardEdge,
          //padding: EdgeInsets.symmetric(vertical: 10),
          itemCount: books.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount, // Number of columns
            mainAxisSpacing: 12.0, // Vertical spacing between items
            crossAxisSpacing:
                crossAxisSpacing, // Horizontal spacing between items
            childAspectRatio:
                dynamicAspectRatio, // Width-to-height ratio of each item
          ),
          itemBuilder: (context, index) {
            // final Book books = storybooks[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Storypages(book: books[index]),
                  ),
                );
              },
              child: Storybookcard(
                storymodel: books[index],
                imageUrl: books[index].coverImage,
              ),
            );
          },
        ),
      ),
    );
  }
}
