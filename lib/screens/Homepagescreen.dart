import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/categories/listofcategory.dart';
import 'package:whisperverse_app/stories/storylist.dart';
import 'package:whisperverse_app/widgets/storybookcard.dart';

class Homepagescreen extends StatefulWidget {
  const new({super.key});

  @override
  State<Homepagescreen> createState() => _HomepagescreenState();
}

class _HomepagescreenState extends State<Homepagescreen> {
  final searchcontroller = TextEditingController();

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
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 1,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 40,
                      width: double.infinity,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.search, color: Colors.black45),
                          SizedBox(width: 5),
                          Expanded(
                            child: TextField(
                              //textAlignVertical: TextAlignVertical.center,
                              controller: searchcontroller,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Search your favorite story book...',
                                hintStyle: GoogleFonts.nunito(
                                  color: Colors.black45,
                                  fontSize: 14,
                                ),

                                border: InputBorder.none,
                              ),
                              style: GoogleFonts.literata(
                                color: Colors.black45,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: categorylist.map((value) {
                        return Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 0.5,
                                blurRadius: 0.5,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Text(value.title),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 500,
                    child: GridView.builder(
                      clipBehavior: Clip.hardEdge,
                      //padding: EdgeInsets.symmetric(vertical: 10),
                      itemCount: storyList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount, // Number of columns
                        mainAxisSpacing: 12.0, // Vertical spacing between items
                        crossAxisSpacing: crossAxisSpacing, // Horizontal spacing between items
                        childAspectRatio: dynamicAspectRatio, // Width-to-height ratio of each item
                      ),
                      itemBuilder: (context, index) {
                        return Storybookcard(storymodel: storyList[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
