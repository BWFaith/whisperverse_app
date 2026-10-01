import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:whisperverse_app/stories/storymodel.dart';

class Storybookcard extends StatelessWidget {
  const Storybookcard({super.key, required this.storymodel});
  final Book storymodel;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              storymodel.coverImage,
              fit: BoxFit.cover,
              //height: 100,
            ),
          ),
          //Positioned(child: Row(children: [])),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      storymodel.title,
                      style: GoogleFonts.nunito(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      storymodel.author,
                      style: GoogleFonts.nunito(
                        color: Colors.black45,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
