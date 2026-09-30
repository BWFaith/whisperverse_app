import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/screens/authenticationScreen/login.dart';

// import 'package:whisperverse_app/screens/Homepagescreen.dart';
// import 'package:whisperverse_app/screens/authenticationScreen/login.dart';
// import 'package:whisperverse_app/widgets/mainbuttons.dart';

class Onboardingscreen extends StatefulWidget {
  const Onboardingscreen({super.key});

  @override
  State<Onboardingscreen> createState() => _OnboardingscreenState();
}

class _OnboardingscreenState extends State<Onboardingscreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 100),
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 300),
              duration: Duration(seconds: 1),
              builder: (context, value, child) {
                return Image.asset('assets/images/logo2.png', width: value);
              },
              child: Text(
                'Never Get Bored!',
                style: GoogleFonts.fredoka(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,

                  color: Colors.black87,
                ),
              ),
            ),

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
            // Mainbuttons(
            //   onTap: () {
            //     Navigator.of(context).pushReplacement(
            //       MaterialPageRoute(builder: (context) => LoginPage()),
            //     );
            //   },
            //   buttonText: 'Get Started',
            // ),
          ],
        ),
      ),
    );
  }
}
