import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/firebase_repository/bookdatabase.dart';
import 'package:whisperverse_app/providers/isfavoriteprovider.dart';
import 'package:whisperverse_app/stories/chaptermodel.dart';
import 'package:whisperverse_app/stories/storymodel.dart';

class Storypages extends ConsumerStatefulWidget {
  const Storypages({super.key, required this.book});
  final Book book;

  @override
  ConsumerState<Storypages> createState() => _StorypagesState();
}

class _StorypagesState extends ConsumerState<Storypages> {
  final controller = PageController();
  int chapterIndex = 0;
  int pageIndex = 0;
  Color nextbuttonColor = Colors.blueAccent;
  Color previousbuttonColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    late List<Book> myfavoritestory;
    late Isfavoriteprovider isFavorite;
    isFavorite = ref.watch(favoriteProvider.notifier);
    myfavoritestory = ref.watch(favoriteProvider);
    final isFav = myfavoritestory.any((b) => b.uid == widget.book.uid);

    final double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
        title: Image.asset(width: 100, 'assets/images/logo2.png'),
        centerTitle: true,
        actionsPadding: EdgeInsets.only(right: 5),
        actions: [
          IconButton(
            onPressed: () {
              isFavorite.toggleFavorite(widget.book);
            },
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : null,
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 240, 214, 204),
      body: FutureBuilder<List<Chapter>>(
        future: BookService().getChapters(widget.book.uid),
        builder: (context, asyncSnapshot) {
          if (!asyncSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final chapters = asyncSnapshot.data!;
          final pages = chapters.first.pages;

          return PageView.builder(
            controller: controller,
            itemCount: pages.length,
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chapter ${chapters[chapterIndex].chapterNumber}',
                    style: GoogleFonts.fredoka(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    chapters[index].title,
                    style: GoogleFonts.fredoka(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: screenheight * 0.7,
                    child: SingleChildScrollView(
                      child: Text(
                        pages[pageIndex],
                        style: GoogleFonts.literata(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            iconColor: previousbuttonColor,
                          ),
                          onPressed: () {
                            if (pageIndex == 0 && chapterIndex == 0) {
                              setState(() {
                                previousbuttonColor = Colors.grey;
                              });
                            } else {
                              setState(() {
                                pageIndex--;
                              });
                            }
                          },
                          label: Text(
                            'Previous',
                            style: TextStyle(
                              color: previousbuttonColor,
                              fontSize: 15,
                            ),
                          ),
                          icon: Icon(Icons.arrow_back),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            setState(() {
                              pageIndex++;
                              previousbuttonColor = Colors.blueAccent;
                            });

                            if (pageIndex == pages.length) {
                              setState(() {
                                chapterIndex++;
                                pageIndex = 0;
                              });
                            }
                            if (chapterIndex == chapters.length ||
                                pageIndex == pages.length) {
                              setState(() {
                                nextbuttonColor = Colors.grey;
                                chapterIndex = 0;
                                pageIndex = 0;
                              });
                              return;
                            }
                          },
                          iconAlignment: IconAlignment.end,
                          icon: Icon(Icons.arrow_forward),
                          style: TextButton.styleFrom(
                            iconColor: Colors.blueAccent,
                          ),
                          label: Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
