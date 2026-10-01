import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profilescreen extends StatefulWidget {
  const new({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),

      body: Center(
        child: Text(
          'Nothing to show yet...',
          style: GoogleFonts.nunito(fontSize: 21),
        ),
      ),

      //fonts: Heading - Fredoka, Subheading - Nunito, Body - Literata
    );
  }
}
