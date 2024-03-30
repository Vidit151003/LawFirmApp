
import 'package:app1/Client_Sign_In_Page.dart';
import 'package:app1/client_dahboard.dart';

import 'package:app1/utils.dart';
import 'package:app1/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pass2 = TextEditingController();

  String? _passError;
  String? _pass2Error;
  String? _emailError;
  bool _passwordVisible = false;
  bool _passwordVisible2 = false;

  @override
  void initState() {
    _passwordVisible = true;
    _passwordVisible2 = true;
    loading = false;
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Form(
        key: _formKey,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue,
                      Colors.white,
                      Colors.white,
                    ],
                  )
              ),

              child: SingleChildScrollView(
                child: Center(
                  child: Stack(
                      children: [
                        Container(
                          height: 760,
                        ),
                        Positioned(
                          left: 0,
                          top: 192,
                          child: SizedBox(
                            width: 320,
                            height: 122,
                            child: Text(
                              'Sign Up',
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
                            child: TextFormField(
                              autocorrect: true,
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                errorText: _emailError,
                              ),
                              onChanged: (_) => setState(() => _emailError = null),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!EmailValidator.validate(value.trim())) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          left: 30,
                          top: 471,
                          child: SizedBox(
                            height: 70,
                            width: 350,
                            child: TextFormField(
                              obscureText: _passwordVisible2,
                              controller: pass2,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _passwordVisible2
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      _passwordVisible2 = !_passwordVisible2;
                                    });
                                  },
                                ),
                                labelText: 'Confirm Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                errorText: _pass2Error,
                              ),
                              onChanged: (_) => setState(() => _pass2Error = null),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                else if(value != passwordController.text)
                                { return 'The passwords do not match';}
                                return null;
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          left: 30,
                          top: 383,
                          child: SizedBox(
                            height: 70,
                            width: 350,
                            child: TextFormField(
                              obscureText: _passwordVisible,
                              controller: passwordController,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                errorText: _passError,
                              ),
                              onChanged: (_) => setState(() => _passError = null),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),

                        Positioned(
                          top: 553,
                            left: 123,
                            child: OvalButtonColor(
                                name: "SignUp",
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      loading=true;
                                    });
                                    try {
                                      signUp(emailController.text, passwordController.text, "client");


                                    } on FirebaseAuthException catch (e) {
                                      setState(() {
                                        loading=false;
                                      });
                                      if (e.code == 'weak-password') {
                                        setState(() {
                                          _passError =
                                          'The password provided is too weak.';
                                        });
                                      } else if (e.code == 'email-already-in-use') {
                                        setState(() {
                                          _emailError =
                                          'The account already exists for that email.';
                                        });
                                      }
                                    } catch (e) {
                                      print(e);
                                    }
                                  }
                                },
                                color1: Colors.blue.shade800)
                        ),

                        Positioned(
                          left: 82,
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
                                        builder: (context) => const ClientSignInPage(),
                                      ),
                                    );
                                  },
                                  child: const Text( 'Login!',
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
                      ],
                    ),
                ),
              ),
            ),
            ),

        ),
      ),
    );
  }

  void signUp(String email, String password, String role) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading=true;
      });
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => { postDetailsToFirestore(email, role)})
          .catchError((e) {
        utils().toastMessage(e.toString());
      });

    }
  }

  postDetailsToFirestore(String email, String role) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference ref = firebaseFirestore.collection('clients');
    ref.doc(user!.email).set({'id':user.uid.toString(), 'role': role, 'ids': DateTime.now().millisecondsSinceEpoch.toString() });
    setState(() {
      loading=false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ClientDashboard(),
      ),
    );
  }
}


