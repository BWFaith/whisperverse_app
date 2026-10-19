import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/firebase_repository/bookdatabase.dart';
import 'package:whisperverse_app/screens/storypages.dart';
import 'package:whisperverse_app/stories/storylist.dart';
import 'package:whisperverse_app/stories/storymodel.dart';
import 'package:whisperverse_app/widgets/storybookcard.dart';

class Discoverscreen extends StatefulWidget {
  const Discoverscreen({super.key});

  @override
  State<Discoverscreen> createState() => _DiscoverscreenState();
}

class _DiscoverscreenState extends State<Discoverscreen> {
  late Stream<List<Book>> _books;

  @override
  void initState() {
    _books = BookService().streamBooks();
    super.initState();
  }

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
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),

      body:
          //fonts: Heading - Fredoka, Subheading - Nunito, Body - Literata
          StreamBuilder<List<Book>>(
            stream: _books,
            builder: (context, asyncSnapshot) {
              final allbooks = asyncSnapshot.data ?? [];
              final Map<String, List<Book>> groupedCategory = {};

              for (final book in allbooks) {
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 20,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          clipBehavior: Clip.hardEdge,

                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(17, 0, 0, 0),
                                spreadRadius: 2,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              ),
                            ],

                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 10,
                            children: [
                              Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    5,
                                  ),
                                ),

                                clipBehavior: Clip.hardEdge,
                                child: Image.asset(
                                  'assets/images/cover2.jpg',
                                  fit: BoxFit.cover,
                                  //height: 100,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                          storyList[0].title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.nunito(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      Row(
                                        spacing: 3,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.visibility_outlined,
                                            size: 18,
                                            color: Colors.black26,
                                          ),
                                          Text(
                                            '3.7k',
                                            style: GoogleFonts.nunito(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black26,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 3),
                                  SizedBox(
                                    width: 225,
                                    child: Text(
                                      storyList[0].description,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.nunito(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
                                          onTap: () {},
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
