import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/firebase_repository/bookdatabase.dart';
import 'package:whisperverse_app/providers/firebaseprovider.dart';
import 'package:whisperverse_app/screens/storypages.dart';
import 'package:whisperverse_app/stories/storymodel.dart';
import 'package:whisperverse_app/widgets/storybookcard.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  late Future<List<String>> historyList;
  late Future<List<Book>> _story;

  @override
  void initState() {
    super.initState();
    _story = BookService().getBooks();
    // historyList = BookService().getViewedIds();
  }

  @override
  Widget build(BuildContext context) {
    final mybooks = ref.watch(allbooksprovider);
    final viewedBooks = ref.watch(viewedbooksprovider);
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
        title: Image.asset(width: 100, 'assets/images/logo2.png'),
      ),
      body: viewedBooks.when(
        error: (error, stackTrace) => Text('Error: $error'),
        loading: () => Center(
          child: const CircularProgressIndicator(color: Colors.blueAccent),
        ),
        data: (data) {
          Widget content = mybooks.when(
            error: (error, stackTrace) => Text('Error: $error'),
            loading: () => const CircularProgressIndicator(),
            data: (books) {
              final viewedBooks = data
                  .map((id) => books.where((book) => book.uid == id))
                  .where((matches) => matches.isNotEmpty)
                  .map((matches) => matches.first)
                  .toList();

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recently Viewed Books',
                        style: GoogleFonts.fredoka(
                          fontSize: 21,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        clipBehavior: Clip.hardEdge,
                        //padding: EdgeInsets.symmetric(vertical: 10),
                        itemCount: viewedBooks.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 12.0,
                          crossAxisSpacing: crossAxisSpacing,
                          childAspectRatio: dynamicAspectRatio,
                        ),
                        itemBuilder: (context, index) {
                          return Storybookcard(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Storypages(book: viewedBooks[index]),
                                ),
                              );
                            },
                            storymodel: viewedBooks[index],
                            imageUrl: viewedBooks[index].coverImage,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );

          if (data.isEmpty) {
            content = Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  textAlign: TextAlign.center,
                  'You haven\'t read any storybook yet...',
                  style: GoogleFonts.nunito(fontSize: 21),
                ),
              ),
            );
          }
          return content;
        },
      ),
    );
  }
}
