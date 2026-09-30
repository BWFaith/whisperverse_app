import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Mainbuttons extends StatelessWidget {
  const Mainbuttons({super.key, required this.onTap, required this.buttonText});
  final void Function()? onTap;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: GoogleFonts.literata(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
