import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/providers/isfavoriteprovider.dart';
import 'package:whisperverse_app/screens/storypages.dart';
import 'package:whisperverse_app/widgets/storybookcard.dart';

class Favoritescreen extends ConsumerStatefulWidget {
  const Favoritescreen({super.key});

  @override
  ConsumerState<Favoritescreen> createState() => _FavoritescreenState();
}

class _FavoritescreenState extends ConsumerState<Favoritescreen> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    const int crossAxisCount = 3;
    const double crossAxisSpacing = 10.0;

    const double desiredItemHeight = 240.0;

    final double totalSpacing = crossAxisSpacing * (crossAxisCount - 1);
    final double itemWidth = (screenWidth - totalSpacing) / crossAxisCount;

    final double dynamicAspectRatio = itemWidth / desiredItemHeight;

    final favoritelist = ref.watch(favoriteProvider);
    final favoriteAsync = ref.watch(favoriteBooksProvider);

    // Widget content = favoriteAsync.when(
    //   error: (error, stackTrace) => Text('Error: $error'),
    //   loading: () => const CircularProgressIndicator(color: Colors.blueAccent),
    //   data: (data) {
    //     return SingleChildScrollView(
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               'My Favorite Books',
    //               style: GoogleFonts.fredoka(
    //                 fontSize: 21,
    //                 fontWeight: FontWeight.w500,
    //               ),
    //             ),
    //             SizedBox(height: 10),
    //             GridView.builder(
    //               shrinkWrap: true,
    //               physics: const NeverScrollableScrollPhysics(),
    //               clipBehavior: Clip.hardEdge,
    //               //padding: EdgeInsets.symmetric(vertical: 10),
    //               itemCount: data.length,
    //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //                 crossAxisCount: crossAxisCount, // Number of columns
    //                 mainAxisSpacing: 12.0, // Vertical spacing between items
    //                 crossAxisSpacing:
    //                     crossAxisSpacing, // Horizontal spacing between items
    //                 childAspectRatio: dynamicAspectRatio, // Width-to-height ratio of each item
    //               ),
    //               itemBuilder: (context, index) {
    //                 return Storybookcard(
    //                   onTap: () {
    //                     Navigator.of(context).push(
    //                       MaterialPageRoute(
    //                         builder: (context) => Storypages(book: data[index]),
    //                       ),
    //                     );
    //                   },
    //                   storymodel: data[index],
    //                   imageUrl: data[index].coverImage,
    //                 );
    //               },
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );

    // if (favoriteAsync.isEmpty) {
    //   return content = Center(
    //     child: Text(
    //       'No Favorite yet...',
    //       style: GoogleFonts.nunito(fontSize: 21),
    //     ),
    //   );
    // }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),

      body: favoriteAsync.when(
        error: (error, stackTrace) => Text('Error: $error'),
        loading: () => Center(
          child: const CircularProgressIndicator(color: Colors.blueAccent),
        ),
        data: (data) {
          Widget content = SingleChildScrollView(
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
                    'My Favorite Books',
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
                    itemCount: data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount, // Number of columns
                      mainAxisSpacing: 12.0, // Vertical spacing between items
                      crossAxisSpacing:
                          crossAxisSpacing, // Horizontal spacing between items
                      childAspectRatio: dynamicAspectRatio, // Width-to-height ratio of each item
                    ),
                    itemBuilder: (context, index) {
                      return Storybookcard(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  Storypages(book: data[index]),
                            ),
                          );
                        },
                        storymodel: data[index],
                        imageUrl: data[index].coverImage,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
          if (data.isEmpty) {
            return content = Center(
              child: Text(
                'No Favorite yet...',
                style: GoogleFonts.nunito(fontSize: 21),
              ),
            );
          }

          return content;
        },
      ),

      //content,

      //fonts: Heading - Fredoka, Subheading - Nunito, Body - Literata
    );
  }
}
