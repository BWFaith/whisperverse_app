import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Mainbuttons extends StatelessWidget {
  const Mainbuttons({super.key, required this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            'Get Started',
            style: GoogleFonts.literata(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
