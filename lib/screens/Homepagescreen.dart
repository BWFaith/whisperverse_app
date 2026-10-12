import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/categories/listofcategory.dart';
import 'package:whisperverse_app/firebase_repository/bookdatabase.dart';
import 'package:whisperverse_app/screens/storypages.dart';
import 'package:whisperverse_app/stories/storymodel.dart';
import 'package:whisperverse_app/widgets/continuereadingbookcard.dart';

class Homepagescreen extends StatefulWidget {
  const Homepagescreen({super.key});

  @override
  State<Homepagescreen> createState() => _HomepagescreenState();
}

class _HomepagescreenState extends State<Homepagescreen> {
  //final BookService _bookService = BookService();
  String selectedCategory = 'All';
  final searchcontroller = TextEditingController();
  final List<Book> mybook = BookService().books;
  late Future<List<Book>> _storybook;
  Color buttonColor = Colors.white;
  @override
  void initState() {
    super.initState();
    _storybook = BookService().getBooks();
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
          FutureBuilder<List<Book>>(
            future: _storybook,
            builder: (context, asyncSnapshot) {
              final allBooks = asyncSnapshot.data ?? [];
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
                    child: Container(
                      clipBehavior: Clip.hardEdge,

                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(17, 0, 0, 0),
                            spreadRadius: 2,
                            blurStyle: BlurStyle.outer,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusGeometry.circular(5),
                            ),

                            clipBehavior: Clip.hardEdge,
                            child: Image.asset(
                              'assets/images/cover2.jpg',
                              fit: BoxFit.cover,
                              //height: 100,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 8.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    books[index].title,
                                    style: GoogleFonts.nunito(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),

                                  Text(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    books[index].author,
                                    style: GoogleFonts.nunito(
                                      color: Colors.black45,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
                      Continuereadingbookcard(),
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
