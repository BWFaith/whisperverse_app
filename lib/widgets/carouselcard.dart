import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/screens/storypages.dart';
import 'package:whisperverse_app/stories/storymodel.dart';

class Carouselcard extends StatefulWidget {
  const Carouselcard({super.key, required this.books});
  final List<Book> books;

  @override
  State<Carouselcard> createState() => _CarouselcardState();
}

class _CarouselcardState extends State<Carouselcard> {
  late final List<Book> _featured;
  int _current = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _featured = ([...widget.books]..shuffle()).take(5).toList();
    if (_featured.length > 1) _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 6), (_) {
      setState(() {
        _current = (_current + 1) % _featured.length;
      });
    });
  }

  Future<void> _openDetail(Book book) async {
    _timer?.cancel(); // pause while the user is away
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Storypages(book: book),
      ), // your detail screen
    );
    if (mounted && _featured.length > 1) _startTimer(); // resume on return
  }

  @override
  void dispose() {
    _timer?.cancel(); // always stop the timer
    super.dispose();
  }

  String formatCount(int n) {
    if (n >= 1000000) {
      return '${_trim(n / 1000000)}M';
    } else if (n >= 1000) {
      return '${_trim(n / 1000)}k';
    }
    return n.toString();
  }

  // 1.0 -> "1", 1.5 -> "1.5"
  String _trim(double value) {
    final s = value.toStringAsFixed(1);
    return s.endsWith('.0') ? s.substring(0, s.length - 2) : s;
  }

  @override
  Widget build(BuildContext context) {
    if (_featured.isEmpty) return const SizedBox.shrink();
    final book = _featured[_current];
    final double screenWidth = MediaQuery.of(context).size.width;
    // Widget imageContent = CachedNetworkImage(
    //   imageUrl: book.coverImage!,
    //   fit: BoxFit.cover,
    //   //height: 100,
    // );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: GestureDetector(
            onTap: () => _openDetail(book),
            behavior: HitTestBehavior.opaque,

            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Container(
                key: ValueKey(
                  book.uid,
                ), // tells Flutter "this is a different card"
                width: double.infinity,
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
                        borderRadius: BorderRadiusGeometry.circular(5),
                      ),

                      clipBehavior: Clip.hardEdge,
                      child: CachedNetworkImage(
                        imageUrl: book.coverImage,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: screenWidth * 0.4,
                              child: Text(
                                book.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.nunito(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),

                            Row(
                              spacing: screenWidth * 0.01,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.visibility_outlined,
                                  size: 18,
                                  color: Colors.black26,
                                ),
                                Text(
                                  '${formatCount(book.viewCount)} Views',
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
                            book.description,
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
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_featured.length, (i) {
            final active = i == _current;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 8,
              width: active ? 22 : 8,
              decoration: BoxDecoration(
                color: active ? Colors.blueAccent : Colors.black26,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}
