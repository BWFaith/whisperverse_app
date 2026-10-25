import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/providers/firebaseprovider.dart';
import 'package:whisperverse_app/screens/history.dart';

class Profilescreen extends ConsumerStatefulWidget {
  const Profilescreen({super.key});

  @override
  ConsumerState<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends ConsumerState<Profilescreen> {
  @override
  Widget build(BuildContext context) {
    final profiledata = ref.watch(userProfileProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),

      body: profiledata.when(
        error: (error, stackTrace) => Text('Error: $error'),
        loading: () => Center(
          child: const CircularProgressIndicator(color: Colors.blueAccent),
        ),
        data: (data) {
          if (data == null) {
            return Center(
              child: Text(
                'No profile found',
                style: GoogleFonts.nunito(fontSize: 21),
              ),
            );
          }

          final username = data['username'] ?? 'Reader';
          final email = data['email'] ?? '';
          return Padding(
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
                      username,
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      email,
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
                        onTap: () {},
                        leading: Icon(Icons.person_3_outlined),
                        title: Text(
                          'Edit Profile',
                          style: GoogleFonts.fredoka(color: Colors.black87),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => HistoryScreen(),
                            ),
                          );
                        },
                        leading: Icon(Icons.visibility_outlined),
                        title: Text(
                          'History',
                          style: GoogleFonts.fredoka(color: Colors.black87),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        onTap: () {},
                        leading: Icon(Icons.settings_outlined),
                        title: Text(
                          'Settings',
                          style: GoogleFonts.fredoka(color: Colors.black87),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
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
          );
        },
      ),

      //fonts: Heading - Fredoka, Subheading - Nunito, Body - Literata
    );
  }
}
