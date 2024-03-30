
import 'package:app1/authority_dashboard.dart';

import 'package:app1/utils.dart';
import 'package:app1/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class AddLawyer extends StatefulWidget {
  const AddLawyer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddLawyerState createState() => _AddLawyerState();
}

class _AddLawyerState extends State<AddLawyer> {
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
    super.initState();
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
                        left: -200,
                        top: 192,
                        child: SizedBox(
                          width: 800,
                          height: 122,
                          child: Text(
                            'Add New Lawyer',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inriaSans(
                              color: const Color(0xFF182448),
                              fontSize: 40,
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
                              labelText: 'Lawyers Email',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              errorText: _emailError,
                            ),
                            onChanged: (_) => setState(() => _emailError = null),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the email';
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
                                return 'Please enter the password';
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
                              name: "Add",
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    loading=true;
                                  });
                                  try {
                                    signUp(emailController.text, passwordController.text, "lawyer");
                                    setState(() {
                                      loading=false;
                                    });


                                  } on FirebaseAuthException catch (e) {
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
    CollectionReference ref = firebaseFirestore.collection('lawyers');
    ref.doc(user!.email).set({'id': user.uid.toString(), 'role': role, 'ids': DateTime.now().millisecondsSinceEpoch.toString() });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthorityDashboard(),));
    utils().toastMessage("Lawyer Added");
  }
}


