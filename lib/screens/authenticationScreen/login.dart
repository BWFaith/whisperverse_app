import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whisperverse_app/screens/authenticationScreen/signupscreen.dart';
import 'package:whisperverse_app/widgets/bottomNavigationBar.dart';
import 'package:whisperverse_app/widgets/mainbuttons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isToggledObscureText = true;
  final _formKey = GlobalKey<FormState>();

  // Track input values
  String _email = '';
  String _password = '';

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator(color: Colors.white));
        },
      );

      //Navigator.of(context).pop();

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        // if (userLogin.user != null && context.mounted) {
        //   Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (_) => const MyBottomnavigationbar()),
        //     (route) => false,
        //   );
        // }

        print('user logged in');
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // Navigator.pop(context);
        // ScaffoldMessenger.of(context).clearSnackBars();
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.code)));

        switch (e.code) {
          case 'invalid-credential':
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Invalid email or password.')),
            );

            break;
          case 'wrong-password':
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('incorrect password')));

            break;
          case 'user-not-found':
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('no user record')));

            break;
          case 'invalid-email':
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Invalid-email')));

            break;
          default:
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('No user record')));
            print('An unknown authentication error occurred: ${e.message}');
        }
      } catch (e) {
        print('A non-Firebase error occurred: $e');

        // showErrorMessage(e.code);
      }
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
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () {
                          // FirebaseAuth.instance.sendPasswordResetEmail(
                          //   email: _email,
                          // );
                        },
                        child: Text(
                          'Forgotten Password?',
                          style: GoogleFonts.nunito(
                            fontSize: 14,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      Mainbuttons(onTap: _submitForm, buttonText: 'Login'),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: GoogleFonts.nunito(fontSize: 15),
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Signupscreen(),
                              ),
                            ),
                            child: Text(
                              'Sign up',
                              style: GoogleFonts.nunito(
                                fontSize: 15,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),

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
