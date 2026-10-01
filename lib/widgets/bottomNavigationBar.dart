import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/screens/Homepagescreen.dart';
import 'package:whisperverse_app/screens/authenticationScreen/login.dart';
import 'package:whisperverse_app/screens/authenticationScreen/signupscreen.dart';
import 'package:whisperverse_app/screens/onboardingscreen.dart';

class MyBottomnavigationbar extends StatefulWidget {
  const new({super.key});

  @override
  State<MyBottomnavigationbar> createState() => _MyBottomnavigationbarState();
}

class _MyBottomnavigationbarState extends State<MyBottomnavigationbar> {
  int _currentpageindex = 0;
  final List<Widget> _screens = [
    const Homepagescreen(),
    const Signupscreen(),
    const LoginPage(),
    const Onboardingscreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      body: _screens[_currentpageindex],

      bottomNavigationBar: CurvedNavigationBar(
        index: _currentpageindex,
        height: screenheight * 0.09,
        items: [
          CurvedNavigationBarItem(
            child: Icon(
              Icons.auto_stories_sharp,
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
