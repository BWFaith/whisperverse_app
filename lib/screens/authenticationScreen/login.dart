import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/widgets/mainbuttons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  // Track input values
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
                        decoration: const InputDecoration(
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

                      Mainbuttons(onTap: _submitForm, buttonText: 'Login'),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: GoogleFonts.nunito(fontSize: 15),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Sign up',
                            style: GoogleFonts.nunito(
                              fontSize: 15,
                              color: Colors.blueAccent,
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
