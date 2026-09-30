import 'package:flutter/material.dart';

class Homepagescreen extends StatefulWidget {
  const new({super.key});

  @override
  State<Homepagescreen> createState() => _HomepagescreenState();
}

class _HomepagescreenState extends State<Homepagescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),

      appBar: AppBar(
        title: Image.asset(width: 100, 'assets/images/logo2.png'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
    );
  }
}
