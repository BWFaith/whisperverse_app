import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/categories/listofcategory.dart';
import 'package:whisperverse_app/firebase_repository/bookdatabase.dart';
import 'package:whisperverse_app/providers/firebaseprovider.dart';
import 'package:whisperverse_app/screens/searchbottomsheet.dart';
import 'package:whisperverse_app/screens/storypages.dart';
import 'package:whisperverse_app/stories/storymodel.dart';
import 'package:whisperverse_app/widgets/continuereadingbookcard.dart';
import 'package:whisperverse_app/widgets/storybookcard.dart';

class Homepagescreen extends ConsumerStatefulWidget {
  const Homepagescreen({super.key});

  @override
  ConsumerState<Homepagescreen> createState() => _HomepagescreenState();
}

class _HomepagescreenState extends ConsumerState<Homepagescreen> {
  String selectedCategory = 'All';
  final searchcontroller = TextEditingController();
  final List<Book> mybook = BookService().books;
  late Future<List<Book>> _storybook;
  // late Future<List<QueryDocumentSnapshot>> _bookmarks;

  Color buttonColor = Colors.white;
  // @override
  // void initState() {
  //   _storybook = BookService().getBooks();
  //   _bookmarks = BookService().getAllBookmarks();
  //   super.initState();
  // }

  void showSearchSheet(BuildContext context, List<Book> books) {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // lets the sheet grow tall and rise above the keyboard
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => FractionallySizedBox(
        heightFactor: 0.9, // sheet takes 90% of screen height
        child: Searchbottomsheet(books: books),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mybooks = ref.watch(allbooksprovider);
    final bookmark = ref.watch(bookmarkedprovider);
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
          mybooks.when(
            error: (e, _) => Text('Error: $e'),
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (allBooks) {
              final books = selectedCategory == 'All'
                  ? allBooks
                  : allBooks
                        .where((book) => book.category == selectedCategory)
                        .toList();

              Widget storyContent = GridView.builder(
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
              );
              if (books.isEmpty) {
                storyContent = const Center(
                  child: Text('No books in this category yet'),
                );
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 15.0,
                  ),
                  child: Column(
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 1,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: 40,
                          width: double.infinity,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.search, color: Colors.black45),
                              SizedBox(width: 5),
                              Expanded(
                                child: TextField(
                                  onTap: () =>
                                      showSearchSheet(context, allBooks),
                                  readOnly: true,
                                  //textAlignVertical: TextAlignVertical.center,
                                  controller: searchcontroller,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText:
                                        'Search your favorite story book...',
                                    hintStyle: GoogleFonts.nunito(
                                      color: Colors.black45,
                                      fontSize: 14,
                                    ),

                                    border: InputBorder.none,
                                  ),
                                  style: GoogleFonts.literata(
                                    color: Colors.black45,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      bookmark.when(
                        error: (error, stackTrace) => Text('Error: $error'),
                        loading: () => const CircularProgressIndicator(),
                        data: (bookmarkedbooks) {
                          if (!bookmarkedbooks.isNotEmpty) {
                            return const SizedBox();
                          }
                          final latest = bookmarkedbooks.first;
                          final bookId = latest.id;
                          final progress = (latest['progress'] as num)
                              .toDouble();

                          final matches = allBooks.where(
                            (b) => b.uid == bookId,
                          );
                          if (matches.isEmpty) return const SizedBox();
                          final book = matches.first;

                          return Continuereadingbookcard(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Storypages(book: book),
                                ),
                              );
                              // print(progress);
                            },
                            bookCover: book.coverImage,
                            bookCategory: book.category,
                            bookTitie: book.title,
                            bookDescription: book.description,
                            percentage: (progress * 100).round(),
                          );
                        },
                      ),

                      SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: categorylist.map((value) {
                            final isSelected = value.title == selectedCategory;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCategory = value.title;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.blueAccent
                                      : buttonColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 0.5,
                                      blurRadius: 0.5,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  value.title,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 10),

                      storyContent,

                      SizedBox(height: 30),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
