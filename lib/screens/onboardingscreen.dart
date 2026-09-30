import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/screens/Homepagescreen.dart';
import 'package:whisperverse_app/widgets/mainbuttons.dart';

class Onboardingscreen extends StatelessWidget {
  const Onboardingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 100),
            Image.asset('assets/images/logo2.png'),

            SizedBox(height: 1),
            Text(
              'Never Get Bored!',
              style: GoogleFonts.fredoka(
                fontSize: 20,
                fontWeight: FontWeight.w500,

                color: Colors.black87,
              ),
            ),
            SizedBox(height: 150),
            Mainbuttons(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Homepagescreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
