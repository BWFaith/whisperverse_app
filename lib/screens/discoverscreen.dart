import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/providers/firebaseprovider.dart';
import 'package:whisperverse_app/screens/categoryscreen.dart';
import 'package:whisperverse_app/screens/storypages.dart';
import 'package:whisperverse_app/stories/storymodel.dart';
import 'package:whisperverse_app/widgets/carouselcard.dart';
import 'package:whisperverse_app/widgets/storybookcard.dart';

class Discoverscreen extends ConsumerStatefulWidget {
  const Discoverscreen({super.key});

  @override
  ConsumerState<Discoverscreen> createState() => _DiscoverscreenState();
}

class _DiscoverscreenState extends ConsumerState<Discoverscreen> {
  //late Future<List<Book>> _books;
  late final List<Book> _featured;
  @override
  void initState() {
    // _books = BookService().getBooks();
    // _featured = ([..._books]..shuffle()).take(5).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final allbooks = ref.watch(allbooksprovider);
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    const int crossAxisCount = 3;
    const double crossAxisSpacing = 10.0;

    const double desiredItemHeight = 240.0;

    final double totalSpacing = crossAxisSpacing * (crossAxisCount - 1);
    final double itemWidth = (screenWidth - totalSpacing) / crossAxisCount;

    final double dynamicAspectRatio = itemWidth / desiredItemHeight;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),

      body:
          //fonts: Heading - Fredoka, Subheading - Nunito, Body - Literata
          allbooks.when(
            error: (error, stackTrace) => Text('Errpr: $error'),
            loading: () => const CircularProgressIndicator(),
            data: (data) {
              final Map<String, List<Book>> groupedCategory = {};

              for (final book in data) {
                groupedCategory.putIfAbsent(book.category, () => []).add(book);
                if (!groupedCategory.containsKey(book.category)) {
                  groupedCategory[book.category] = [];
                }
                //groupedCategory[book.category]!.add(book);
              }

              final categories = groupedCategory.keys.toList();

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    //horizontal: 10.0,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.17,
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Carouselcard(books: data);
                          },
                        ),
                      ),
                      ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          //final category = categories[index];
                          final categoryName = categories[index];
                          final categoryBooks = groupedCategory[categoryName]!;
                          // final books = allbooks.where((book) {
                          //   return book.category == category.title;
                          // }).toList();
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 15.0,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 20),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          categoryName,
                                          style: GoogleFonts.fredoka(
                                            fontSize: 21,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Categoryscreen(
                                                      categoryTitle:
                                                          categoryName,
                                                      books: categoryBooks,
                                                    ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'View all',
                                            style: GoogleFonts.fredoka(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 220,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: categoryBooks.length,
                                        itemBuilder: (context, index) {
                                          // final mybook = books[index];

                                          return SizedBox(
                                            width: 120,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 4.0,
                                                  ),
                                              child: Storybookcard(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Storypages(
                                                            book:
                                                                categoryBooks[index],
                                                          ),
                                                    ),
                                                  );
                                                },
                                                storymodel:
                                                    categoryBooks[index],
                                                imageUrl: categoryBooks[index]
                                                    .coverImage,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
