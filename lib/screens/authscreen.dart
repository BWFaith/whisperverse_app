import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whisperverse_app/screens/onboardingscreen.dart';
import 'package:whisperverse_app/widgets/bottomNavigationBar.dart';

class Authscreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MyBottomnavigationbar();
          } else {
            return Onboardingscreen();
          }
        },
      ),
    );
  }
}
