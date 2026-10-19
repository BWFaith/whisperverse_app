import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

class Continuereadingbookcard extends StatelessWidget {
  const Continuereadingbookcard({
    super.key,
    required this.bookCover,
    required this.bookCategory,
    required this.bookTitie,
    required this.bookDescription,
    this.onTap,
    required this.percentage,
  });
  final String bookCover;
  final String bookCategory;
  final String bookTitie;
  final String bookDescription;
  final VoidCallback? onTap;
  final int percentage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                borderRadius: BorderRadiusGeometry.circular(5),
              ),

              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: bookCover,
                //height: 100,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(28, 33, 149, 243),
                  ),
                  child: Text(
                    bookCategory,
                    style: GoogleFonts.literata(fontSize: 10),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        bookTitie,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunito(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3),
                SizedBox(
                  width: 225,
                  child: Text(
                    bookDescription,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Row(
                  spacing: 3,
                  children: [
                    SizedBox(
                      height: 5,
                      width: 100,

                      child: LinearProgressBar(
                        borderRadius: BorderRadiusGeometry.circular(5),
                        backgroundColor: Colors.black12,
                        progressColor: Colors.blueAccent,
                        maxSteps: 100,
                        currentStep: percentage,
                      ),
                    ),

                    Text(
                      '${percentage.toString()}% Complete',
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
          ],
        ),
      ),
    );
  }
}
