import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepagescreen extends StatefulWidget {
  const new({super.key});

  @override
  State<Homepagescreen> createState() => _HomepagescreenState();
}

class _HomepagescreenState extends State<Homepagescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      drawer: Drawer(),
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Image.asset(width: 100, 'assets/images/logo2.png'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),
      body:
          //fonts: Heading - Fredoka, Subheading - Nunito, Body - Literata
          Padding(
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
                    width: 150,

                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.black45),
                        Expanded(
                          child: TextField(
                            style: GoogleFonts.literata(color: Colors.black45),
                          ),
                        ),
                        Text(
                          'Search...',
                          style: GoogleFonts.literata(color: Colors.black45),
                        ),
                      ],
                    ),
                  ),
                ),
                // Text(
                //   'Hello Faith',
                //   style: GoogleFonts.fredoka(
                //     fontSize: 21,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
              ],
            ),
          ),
    );
  }
}
