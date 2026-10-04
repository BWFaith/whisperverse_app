import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/screens/authenticationScreen/login.dart';
import 'package:whisperverse_app/widgets/bottomNavigationBar.dart';
import 'package:whisperverse_app/widgets/mainbuttons.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  bool isToggledObscureText = true;
  final _formKey = GlobalKey<FormState>();

  // Track input values
  String _username = '';
  String _email = '';
  String _password = '';

  // void _submitForm() async {
  //   // showDialog(
  //   //   context: context,
  //   //   builder: (context) => CircularProgressIndicator(),
  //   // );
  //   try {
  //     // if (_formKey.currentState!.validate()) {
  //     //   // 3. Save the form state if validation passes
  //     //   _formKey.currentState!.save();

  //     //   // Process the validated data (e.g., send to an API backend)
  //     //   ScaffoldMessenger.of(context).showSnackBar(
  //     //     SnackBar(content: Text('Processing Data for $_email...')),
  //     //   );
  //     // }
  //     // final credential =
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: _email,
  //       password: _password,
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     //print(e);
  //     Navigator.pop(context);
  //   }
  // }

  void signuserup() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator(color: Colors.white));
        },
      );
      Navigator.of(context).pop();
    }
    // ScaffoldMessenger.of(
    //   context,
    // ).showSnackBar(SnackBar(content: Text('Processing Data for $_email...')));

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      // if (userAuth.user != null && context.mounted) {
      //   Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (_) => const MyBottomnavigationbar()),
      //     (route) => false,
      //   );
      // }

      print('user logged in');
      // Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      // Navigator.pop(context);
      // ScaffoldMessenger.of(context).clearSnackBars();
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.code)));

      switch (e.code) {
        case 'email-already-in-use':
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('This email is already registered. Please log in.'),
            ),
          );
          print('This email is already registered. Please log in.');
          Navigator.of(context).pop();
          break;
        case 'invalid-email':
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The email address is not valid.')),
          );
          print('The email address is not valid.');
          Navigator.of(context).pop();
          break;
        case 'weak-password':
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'The password is too weak. Choose at least 6 characters.',
              ),
            ),
          );
          print('The password is too weak. Choose at least 6 characters.');
          Navigator.of(context).pop();
          break;
        case 'operation-not-allowed':
          print('Email/Password sign up is not enabled in Firebase Console.');
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'An unknown authentication error occurred: ${e.message}',
              ),
            ),
          );
          print('An unknown authentication error occurred: ${e.message}');
      }
    } catch (e) {
      print('A non-Firebase error occurred: $e');

      // showErrorMessage(e.code);
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
                              value.trim().length < 4) {
                            return 'Please enter a minimum of 4 characters';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _username = value ?? '';
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
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            color: Colors.black45,
                            onPressed: () {
                              setState(() {
                                isToggledObscureText = !isToggledObscureText;
                              });
                            },
                            icon: Icon(
                              isToggledObscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: isToggledObscureText,
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

                      Mainbuttons(
                        onTap: signuserup,
                        buttonText: 'Create an account',
                      ),
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
