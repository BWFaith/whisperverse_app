import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:whisperverse_app/providers/firebaseprovider.dart';
import 'package:whisperverse_app/screens/storypages.dart';

import 'package:whisperverse_app/widgets/storybookcard.dart';

class Shortstories extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<Shortstories> createState() => _ShortstoriesState();
}

class _ShortstoriesState extends ConsumerState<Shortstories> {
  // late Future<List<Book>> _shortStories;

  // @override
  // void initState() {
  //   super.initState();
  //   _shortStories = BookService().getBooks();
  // }

  @override
  Widget build(BuildContext context) {
    final shortstories = ref.watch(allbooksprovider);
    final double screenWidth = MediaQuery.of(context).size.width;
    const int crossAxisCount = 3;
    const double crossAxisSpacing = 10.0;

    const double desiredItemHeight = 240.0;

    final double totalSpacing = crossAxisSpacing * (crossAxisCount - 1);
    final double itemWidth = (screenWidth - totalSpacing) / crossAxisCount;

    final double dynamicAspectRatio = itemWidth / desiredItemHeight;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Short Stories',
          style: GoogleFonts.fredoka(
            fontSize: 18,
            fontWeight: FontWeight.w500,

            color: Colors.black87,
          ),
        ),
      ),
      body: shortstories.when(
        error: (error, stackTrace) => Text('Error: $error'),
        loading: () =>
            const CircularProgressIndicator(color: Colors.blueAccent),
        data: (allBooks) {
          final mybooks = allBooks
              .where((book) => book.category == 'Short Stories')
              .toList();
          Widget shortstoryContent = GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            clipBehavior: Clip.hardEdge,
            //padding: EdgeInsets.symmetric(vertical: 10),
            itemCount: mybooks.length,
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
              return Storybookcard(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Storypages(book: mybooks[index]),
                    ),
                  );
                },
                storymodel: mybooks[index],
                imageUrl: mybooks[index].coverImage,
              );
            },
          );
          if (mybooks.isEmpty) {
            shortstoryContent = const Center(
              child: Text('No books in this category yet'),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              child: shortstoryContent,
            ),
          );
        },
      ),
    );
  }
}
