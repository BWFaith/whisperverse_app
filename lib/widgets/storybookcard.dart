import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/screens/storypages.dart';

import 'package:whisperverse_app/stories/storymodel.dart';

class Storybookcard extends StatelessWidget {
  const Storybookcard({super.key, required this.storymodel});
  final Book storymodel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Storypages(book: storymodel)),
        );
      },
      child: Container(
        clipBehavior: Clip.hardEdge,

        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          //borderRadius: BorderRadius.circular(15),
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
                storymodel.coverImage!,
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
                      storymodel.title,
                      style: GoogleFonts.nunito(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      storymodel.author,
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
  }
}
