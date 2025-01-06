import 'package:flutter/material.dart';
import 'package:app1/Screens/ForgotPassword.dart';
import 'package:app1/dashbord/authority_dashboard.dart';
import 'package:app1/Screens/client_sign_up_page.dart';
import 'package:app1/dashbord/lawyer_dashboard.dart';
import 'package:app1/widgets/utils.dart';
import 'package:app1/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dashbord/client_dashboard.dart';

class ClientSignInPage extends StatefulWidget {
  const ClientSignInPage({Key? key});

  @override
  _ClientSignIn createState() => _ClientSignIn();
}

class _ClientSignIn extends State<ClientSignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool loading = false;
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
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
          child: Center(
            child: Stack(
              children: [
                Positioned(
                  left: -40,
                  top: 192,
                  child: SizedBox(
                    width: 320,
                    height: 122,
                    child: Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inriaSans(
                        color: const Color(0xFF182448),
                        fontSize: 64,
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 27,
                  top: 295,
                  child: SizedBox(
                    height: 70,
                    width: 350,
                    child: TextField(
                      autocorrect: true,
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 27,
                  top: 383,
                  child: SizedBox(
                    height: 70,
                    width: 350,
                    child: TextField(
                      obscureText: _passwordVisible,
                      controller: passwordController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 120,
                  top: 490,
                  child: SizedBox(
                    height: 60,
                    width: 150,
                    child: OvalButtonColor(
                      color1: Colors.blue.shade800,
                      name: "Login",
                      loading: loading,
                      onPressed: () async {
                        if (emailController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Please enter your Email and Password.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          setState(() {
                            loading = true;
                          });
                          try {
                            final userCredential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                            if (userCredential.user != null) {
                              checkData(userCredential.user!.email);
                            }
                          } on FirebaseAuthException catch (e) {
                            setState(() {
                              loading = false;
                            });
                            utils()
                                .toastMessage(e.message ?? 'Failed to sign in');
                          }
                        }
                      },
                    ),
                  ),
                ),
                Positioned(
                  left: 75,
                  top: 700,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already a user?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(0xFF004178),
                            fontSize: 18,
                            fontFamily: 'Inria Sans',
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 445,
                  right: 10,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordPage()));
                    },
                    child: Text(
                      "Forgot Password",
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

void checkData(String? email) async {
  try {
    final clientSnapshot = await FirebaseFirestore.instance.collection("clients").doc(email).get();
    final lawyerSnapshot = await FirebaseFirestore.instance.collection("lawyers").doc(email).get();
    final authoritySnapshot = await FirebaseFirestore.instance.collection("authorities").doc(email).get();

    if (clientSnapshot.exists) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ClientDashboard(userEmail: email ?? '')));
    } else if (lawyerSnapshot.exists) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LawyerDashboard()));
    } else if (authoritySnapshot.exists) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthorityDashboard()));
    } else {
      utils().toastMessage("User Data not Found");
    }
  } catch (e) {
    utils().toastMessage("Error: $e");
  } finally {
    setState(() {
      loading = false;
    });
  }
}

}
