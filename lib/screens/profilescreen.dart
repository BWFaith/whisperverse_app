import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),

      body: Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            children: [
              Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 55,
                      child: Image.asset(
                        'assets/images/avata.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Mineer',
                    style: GoogleFonts.nunito(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'Mine@gmail.com',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black38,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Card(
                color: const Color.fromARGB(237, 252, 252, 252),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person_3_outlined),
                      title: Text(
                        'Edit Profile',
                        style: GoogleFonts.fredoka(color: Colors.black87),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.visibility_outlined),
                      title: Text(
                        'History',
                        style: GoogleFonts.fredoka(color: Colors.black87),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.settings_outlined),
                      title: Text(
                        'Settings',
                        style: GoogleFonts.fredoka(color: Colors.black87),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    Divider(color: const Color.fromARGB(78, 158, 158, 158)),
                    SizedBox(height: 50),
                    ListTile(
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                      },
                      leading: Icon(Icons.logout_outlined, color: Colors.red),
                      title: Text(
                        'Log Out',
                        style: GoogleFonts.fredoka(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      //fonts: Heading - Fredoka, Subheading - Nunito, Body - Literata
    );
  }
}
