import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/stories/storylist.dart';

class Continuereadingbookcard extends StatefulWidget {
  const new({super.key});

  @override
  State<Continuereadingbookcard> createState() =>
      _ContinuereadingbookcardState();
}

class _ContinuereadingbookcardState extends State<Continuereadingbookcard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Image.asset(
              storyList[0].coverImage,
              fit: BoxFit.cover,
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
                  storyList[0].category,
                  style: GoogleFonts.literata(fontSize: 10),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      storyList[0].title,
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
                  storyList[0].description,
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
                  Container(
                    height: 5,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  Text(
                    '100% Complete',
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
    );
  }
}
