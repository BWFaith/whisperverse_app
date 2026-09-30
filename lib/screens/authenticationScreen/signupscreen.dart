import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/screens/authenticationScreen/login.dart';
import 'package:whisperverse_app/widgets/mainbuttons.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  final _formKey = GlobalKey<FormState>();

  // Track input values
  final String _username = '';
  String _email = '';
  String _password = '';

  void _submitForm() {
    // 2. Trigger validation across all fields
    if (_formKey.currentState!.validate()) {
      // 3. Save the form state if validation passes
      _formKey.currentState!.save();

      // Process the validated data (e.g., send to an API backend)
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Processing Data for $_email...')));
    }
  }

  //fonts: Heading - Fredoka, Subheading - Nunito, Body - Literata
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/logo2.png', width: 150),
              SizedBox(height: 15),
              Text(
                'Welcome back, reader',
                style: GoogleFonts.nunito(
                  fontSize: 21,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        autocorrect: false,
                        decoration: const InputDecoration(
                          helperStyle: TextStyle(color: Colors.blue),
                          hintStyle: TextStyle(color: Colors.blue),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          labelText: 'Choose a Username',
                          border: OutlineInputBorder(),
                        ),

                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().length < 5) {
                            return 'Please enter a minimum of 5 characters';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value ?? '';
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          labelText: 'Email Address',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email = value ?? '';
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value ?? '';
                        },
                      ),
                      const SizedBox(height: 24),

                      Mainbuttons(onTap: _submitForm, buttonText: 'Sign up'),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: GoogleFonts.nunito(fontSize: 15),
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            ),
                            child: Text(
                              'Sign in',
                              style: GoogleFonts.nunito(
                                fontSize: 15,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                          //TextButton(onPressed: () {}, child: Text('Sign Up')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
