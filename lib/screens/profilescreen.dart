import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/stories/storylist.dart';
import 'package:whisperverse_app/widgets/storybookcard.dart';

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
      drawer: Drawer(),
      appBar: AppBar(
        leadingWidth: 30.0,
        forceMaterialTransparency: true,
        title: Image.asset(width: 100, 'assets/images/logo2.png'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),

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
