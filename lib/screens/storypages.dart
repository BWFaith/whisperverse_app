import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:whisperverse_app/firebase_repository/bookdatabase.dart';
import 'package:whisperverse_app/providers/isfavoriteprovider.dart';
import 'package:whisperverse_app/stories/chaptermodel.dart';
import 'package:whisperverse_app/stories/storymodel.dart';
import 'package:whisperverse_app/widgets/texticonbutton.dart';

class Storypages extends ConsumerStatefulWidget {
  const Storypages({super.key, required this.book});
  final Book book;

  @override
  ConsumerState<Storypages> createState() => _StorypagesState();
}

class _StorypagesState extends ConsumerState<Storypages> {
  @override
  void initState() {
    super.initState();
    BookService().saveViewed(widget.book.uid);
    //ViewService().registerView(widget.book.uid);
    // _loadBookmark();
  }

  int chapterIndex = 0;
  int pageIndex = 0;
  Color nextbuttonColor = Colors.blueAccent;
  Color previousbuttonColor = Colors.grey;
  PageController controller = PageController(initialPage: 0);

  Future<void> _loadBookmark() async {
    final doc = await BookService().getBookmark(widget.book.uid);

    if (doc.exists) {
      chapterIndex = doc['chapterIndex'];
      pageIndex = doc['pageIndex'];
    }

    setState(() {
      controller = PageController(initialPage: pageIndex);
    });
  }

  double calculateProgress({
    required List<Chapter> chapters,
    required int chapterIndex,
    required int pageIndex,
  }) {
    // total pages across ALL chapters
    final totalPages = chapters.fold<int>(
      0,
      (sum, ch) => sum + ch.pages.length,
    );
    if (totalPages == 0) return 0;

    // pages in every chapter before the current one
    int pagesBefore = 0;
    for (int i = 0; i < chapterIndex; i++) {
      pagesBefore += chapters[i].pages.length;
    }

    final pagesRead = pagesBefore + pageIndex + 1;
    return pagesRead / totalPages; // a value from 0.0 to 1.0
  }

  @override
  Widget build(BuildContext context) {
    final isFav =
        ref.watch(favoriteIdsProvider).value?.contains(widget.book.uid) ??
        false;
    late List<Book> myfavoritestory;
    late Isfavoriteprovider isFavorite;
    isFavorite = ref.watch(favoriteProvider.notifier);
    myfavoritestory = ref.watch(favoriteProvider);
    final isFavv = myfavoritestory.any((b) => b.uid == widget.book.uid);

    final double screenheight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
        title: Image.asset(width: 100, 'assets/images/logo2.png'),
        centerTitle: true,
        actionsPadding: EdgeInsets.only(right: 5),
        actions: [
          IconButton(
            onPressed: () {
              ref
                  .read(favoriteActionsProvider)
                  .toggle(widget.book, isFavorite: isFav);
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
            return Center(
              child: Lottie.asset('assets/lottie/openbook.json', width: 200),
            );
          }

          final chapters = asyncSnapshot.data!;
          final page = chapters[chapterIndex].pages;

          Widget chapterTitle = Text(
            chapters[chapterIndex].title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.fredoka(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          );
          if (chapters[chapterIndex].title.isEmpty) {
            chapterTitle = SizedBox(height: 5);
          }

          return PageView.builder(
            controller: controller,
            itemCount: page.length,
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
                  chapterTitle,
                  SizedBox(height: 10),
                  SizedBox(
                    height: screenheight * 0.65,
                    child: SingleChildScrollView(
                      child: Text(
                        page[pageIndex],
                        style: GoogleFonts.literata(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      children: [
                        Texticonbutton(
                          onTap: () {
                            final isFirstPage = pageIndex == 0;
                            final isFirstChapter = chapterIndex == 0;

                            if (!isFirstPage) {
                              setState(() {
                                pageIndex--;
                                nextbuttonColor = Colors.blueAccent;
                              });
                            } else if (!isFirstChapter) {
                              setState(() {
                                chapterIndex--;

                                pageIndex =
                                    chapters[chapterIndex].pages.length - 1;
                                nextbuttonColor = Colors.blueAccent;
                              });
                            } else {
                              setState(() {
                                previousbuttonColor = Colors.grey;
                              });
                            }
                          },
                          buttonasset1: Icon(
                            Icons.arrow_back,
                            color: previousbuttonColor,
                            size: 18,
                          ),
                          buttonasset2: Text(
                            'Previous',
                            style: TextStyle(
                              color: previousbuttonColor,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(width: screenwidth * 0.23),
                        Text(
                          '${pageIndex + 1}',
                          style: GoogleFonts.nunito(
                            fontSize: 13,
                            color: Colors.black38,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: screenwidth * 0.25),
                        Texticonbutton(
                          onTap: () {
                            final progress = calculateProgress(
                              chapters: chapters,
                              chapterIndex: chapterIndex,
                              pageIndex: pageIndex,
                            );

                            BookService().saveBookmark(
                              widget.book.uid,
                              chapterIndex,
                              pageIndex,
                              progress,
                            );

                            final isLastPage = pageIndex >= page.length - 1;
                            final isLastChapter =
                                chapterIndex >= chapters.length - 1;

                            if (!isLastPage) {
                              // more pages in this chapter
                              setState(() {
                                pageIndex++;
                                previousbuttonColor = Colors.blueAccent;
                              });
                            } else if (!isLastChapter) {
                              // last page of chapter, but another chapter exists
                              setState(() {
                                chapterIndex++;
                                pageIndex = 0;
                                previousbuttonColor = Colors.blueAccent;
                              });
                            } else {
                              setState(() {
                                nextbuttonColor = Colors.grey;
                              });

                              return;
                            }
                          },
                          buttonasset1: Text(
                            'Next',
                            style: TextStyle(
                              color: nextbuttonColor,
                              fontSize: 15,
                            ),
                          ),
                          buttonasset2: Icon(
                            Icons.arrow_forward,
                            color: nextbuttonColor,
                            size: 18,
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
