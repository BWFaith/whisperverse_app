import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:whisperverse_app/stories/storymodel.dart';

class Storybookcard extends StatelessWidget {
  const Storybookcard({
    super.key,
    required this.storymodel,
    this.onTap,
    required this.imageUrl,
  });
  final Book storymodel;
  final String imageUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusGeometry.circular(5),
              ),

              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: imageUrl,
                //height: 100,
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
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
