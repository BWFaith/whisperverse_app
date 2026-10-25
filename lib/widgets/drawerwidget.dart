import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/screens/history.dart';
import 'package:whisperverse_app/screens/shortstories.dart';

class Drawerwidget extends StatelessWidget {
  const Drawerwidget({super.key, this.tapfavorite, this.tapprofile});
  final void Function()? tapfavorite;
  final void Function()? tapprofile;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo2.png', width: 200),
                Text(
                  'Never Get Bored!',
                  style: GoogleFonts.fredoka(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,

                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => HistoryScreen()));
            },
            leading: Icon(Icons.visibility_outlined),
            title: Text(
              'History',
              style: GoogleFonts.fredoka(color: Colors.black87),
            ),
          ),
          ListTile(
            onTap: tapfavorite,
            leading: Icon(Icons.favorite_outline_outlined),
            title: Text(
              'Favorite',
              style: GoogleFonts.fredoka(color: Colors.black87),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => Shortstories()));
            },
            leading: Icon(Icons.bookmark_border),
            title: Text(
              'Short Stories',
              style: GoogleFonts.fredoka(color: Colors.black87),
            ),
          ),
          ListTile(
            onTap: tapprofile,
            leading: Icon(Icons.person_3_outlined),
            title: Text(
              'Profile',
              style: GoogleFonts.fredoka(color: Colors.black87),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.settings_outlined),
            title: Text(
              'Settings',
              style: GoogleFonts.fredoka(color: Colors.black87),
            ),
          ),
          Spacer(),
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
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
