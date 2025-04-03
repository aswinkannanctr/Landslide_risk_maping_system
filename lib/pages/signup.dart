import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:land_slade_guardian/pages/home.dart';
import 'package:land_slade_guardian/pages/login.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signUp() async {
    try {
      // Validate inputs
      if (_passwordController.text != _confirmPasswordController.text) {
        _showErrorDialog('Passwords do not match');
        return;
      }

      if (_nameController.text.isEmpty || 
          _emailController.text.isEmpty || 
          _passwordController.text.isEmpty) {
        _showErrorDialog('Please fill in all fields');
        return;
      }

      // Create user with Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Optional: Update user profile with name
      await userCredential.user?.updateDisplayName(_nameController.text.trim());

      // Navigate to home page after successful signup
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homeui()),
      );
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication errors
      String errorMessage = 'An error occurred';
      if (e.code == 'weak-password') {
        errorMessage = 'The password is too weak';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'An account already exists with this email';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email address';
      }
      _showErrorDialog(errorMessage);
    } catch (e) {
      _showErrorDialog('Signup failed. Please try again.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            // App Title
            const Text(
              'LANDSLIDE\nGUARDIAN',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w400,
                color: Color(0xFFBEAA8F),
                height: 1.2,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 60),
            // Name TextField
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'NAME',
                hintStyle: TextStyle(
                  color: Color(0xFFBEAA8F),
                  fontSize: 16,
                  letterSpacing: 1.5,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBEAA8F)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBEAA8F)),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Email TextField
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'EMAIL',
                hintStyle: TextStyle(
                  color: Color(0xFFBEAA8F),
                  fontSize: 16,
                  letterSpacing: 1.5,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBEAA8F)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBEAA8F)),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Password TextField
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'PASSWORD',
                hintStyle: TextStyle(
                  color: Color(0xFFBEAA8F),
                  fontSize: 16,
                  letterSpacing: 1.5,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBEAA8F)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBEAA8F)),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Confirm Password TextField
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'CONFIRM PASSWORD',
                hintStyle: TextStyle(
                  color: Color(0xFFBEAA8F),
                  fontSize: 16,
                  letterSpacing: 1.5,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBEAA8F)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBEAA8F)),
                ),
              ),
            ),
            const SizedBox(height: 48),
            // Create Account Button
            ElevatedButton(
              onPressed: _signUp,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBEAA8F),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Create an account',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            // Back to Login Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBEAA8F),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Back to Login',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up controllers
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}