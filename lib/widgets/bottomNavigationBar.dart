import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/screens/favoritescreen.dart';
import 'package:whisperverse_app/screens/homepagescreen.dart';

import 'package:whisperverse_app/screens/discoverscreen.dart';

import 'package:whisperverse_app/screens/profilescreen.dart';
import 'package:whisperverse_app/widgets/drawerwidget.dart';

class MyBottomnavigationbar extends StatefulWidget {
  const new({super.key});

  @override
  State<MyBottomnavigationbar> createState() => _MyBottomnavigationbarState();
}

class _MyBottomnavigationbarState extends State<MyBottomnavigationbar> {
  int _currentpageindex = 0;

  final List<Widget> _screens = [
    const Homepagescreen(),
    const Discoverscreen(),
    const Favoritescreen(),
    const Profilescreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      extendBody: true,
      drawer: Drawerwidget(
        tapfavorite: () {
          Navigator.of(context).pop();
          setState(() {
            _currentpageindex = 2;
          });
        },
        tapprofile: () {
          Navigator.of(context).pop();
          setState(() {
            _currentpageindex = 3;
          });
        },
      ),
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 5),
        leadingWidth: 30.0,

        forceMaterialTransparency: true,
        title: Image.asset(width: 100, 'assets/images/logo2.png'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          CircleAvatar(
            radius: 15,
            child: Image.asset('assets/images/avata.png', fit: BoxFit.cover),
          ),
        ],
      ),
      body: _screens[_currentpageindex],

      bottomNavigationBar: CurvedNavigationBar(
        index: _currentpageindex,
        height: screenheight * 0.09,
        items: [
          CurvedNavigationBarItem(
            child: Icon(
              Icons.auto_stories_outlined,
              size: 30,
              color: Color.fromARGB(255, 243, 243, 243),
            ),
            label: 'Library',
            labelStyle: GoogleFonts.nunito(
              color: Color.fromARGB(255, 243, 243, 243),
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          CurvedNavigationBarItem(
            child: Icon(
              Icons.find_replace_sharp,
              size: 30,
              color: Color.fromARGB(255, 243, 243, 243),
            ),
            label: 'Discover',
            labelStyle: GoogleFonts.nunito(
              color: Color.fromARGB(255, 243, 243, 243),
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          CurvedNavigationBarItem(
            child: Icon(
              Icons.favorite_border,
              size: 30,
              color: Color.fromARGB(255, 243, 243, 243),
            ),
            label: 'Favorites',
            labelStyle: GoogleFonts.nunito(
              color: Color.fromARGB(255, 243, 243, 243),
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          CurvedNavigationBarItem(
            child: Icon(
              Icons.person_3_outlined,
              size: 30,
              color: Color.fromARGB(255, 243, 243, 243),
            ),
            label: 'Profile',
            labelStyle: GoogleFonts.nunito(
              color: Color.fromARGB(255, 243, 243, 243),
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
        color: Colors.blueAccent, // Navigation bar color
        buttonBackgroundColor:
            Colors.blueAccent, // Background of the popping floating button
        backgroundColor:
            Colors.transparent, // Matches the Scaffold body backing layout
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _currentpageindex = index; // Handle tab click changes
          });
        },
      ),
    );
  }
}
