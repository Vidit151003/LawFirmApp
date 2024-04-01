import 'package:app1/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'welcome_page.dart'; // Import your WelcomePage

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _resetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text);
      // Show success message and navigate to WelcomePage
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Password Reset Email Sent'),
            content: const Text(
              'Check your email for instructions to reset your password.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const WelcomePage()),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      // Show error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
              'Failed to send password reset email. Please check your email and try again.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(0, 65, 120, 1),
              Colors.white,
              Colors.white,
            ],
          )),

      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Forgot Password'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue,
                  Colors.white,
                  Colors.white,
                ],
              )),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                OvalButtonSmall(name: "Submit", onPressed: _resetPassword)
              ],
            ),
          ),
        ),
      ),
    );
  }
}