import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/stories/storylist.dart';
import 'package:whisperverse_app/widgets/storybookcard.dart';

class Discoverscreen extends StatefulWidget {
  const new({super.key});

  @override
  State<Discoverscreen> createState() => _DiscoverscreenState();
}

class _DiscoverscreenState extends State<Discoverscreen> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    const int crossAxisCount = 3;
    const double crossAxisSpacing = 10.0;

    const double desiredItemHeight = 250.0;

    final double totalSpacing = crossAxisSpacing * (crossAxisCount - 1);
    final double itemWidth = (screenWidth - totalSpacing) / crossAxisCount;

    final double dynamicAspectRatio = itemWidth / desiredItemHeight;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      drawer: Drawer(),
      appBar: AppBar(
        leadingWidth: 30.0,
        forceMaterialTransparency: true,
        title: Image.asset(width: 100, 'assets/images/logo2.png'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),

      body:
          //fonts: Heading - Fredoka, Subheading - Nunito, Body - Literata
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
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
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                SizedBox(width: 30),
                                Row(
                                  spacing: 3,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.visibility_outlined,
                                      size: 18,
                                      color: Colors.black26,
                                    ),
                                    Text(
                                      '3.7k',
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
                                storyList[0].description,
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

                  SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    clipBehavior: Clip.hardEdge,
                    //padding: EdgeInsets.symmetric(vertical: 10),
                    itemCount: 3,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount, // Number of columns
                      mainAxisSpacing: 12.0, // Vertical spacing between items
                      crossAxisSpacing:
                          crossAxisSpacing, // Horizontal spacing between items
                      childAspectRatio: dynamicAspectRatio, // Width-to-height ratio of each item
                    ),
                    itemBuilder: (context, index) {
                      return Storybookcard(storymodel: storyList[index]);
                    },
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
