import 'package:app1/dashbord/client_dahboard.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app1/utils.dart';


class VerifyScreen extends StatefulWidget {
  final String verificationId;
  final String email;

  const VerifyScreen({super.key, required this.verificationId, required this.email});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  bool loading = false;

  final phoneCodeController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 280,
                width: 500,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 65, 120, 0.2),
                      spreadRadius: 6,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Verify",
                          style: TextStyle(
                            fontFamily: "Kadwa",
                            fontStyle: FontStyle.italic,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 32),
                        TextFormField(
                          controller: phoneCodeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: '6 digit OTP',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: const TextStyle(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                            signInAndStoreDetails();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signInAndStoreDetails() async {
    final credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: phoneCodeController.text.toString(),
    );

    try {
      await auth.signInWithCredential(credential);

      // Store user details to Firestore
      await postDetailsToFirestore(widget.email);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ClientDashboard(),
        ),
      );
    } catch (e) {
      utils().toastMessage(e.toString());
    }
  }

  Future<void> postDetailsToFirestore(String email) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = auth.currentUser;

    CollectionReference ref = firebaseFirestore.collection('clients');
    ref.doc(widget.email).set({
      'id': user!.uid,
      'email': email,
    });
  }
}

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  bool loading = false;

  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 200),
                  const Text(
                    'Login',
                    style: TextStyle(
                      color: Color(0xFF182448),
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter number here',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      signInWithemail();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    ),
                    child: const Text(
                      "Get OTP",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signInWithemail() async {
    loading = true;
    auth.verifyPhoneNumber(
      phoneNumber: "+91${emailController.text}",
      verificationCompleted: (_) {},
      verificationFailed: (e) {
        utils().toastMessage(e.toString());
      },
      codeSent: (String verificationId, int? token) {
        loading = false;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyScreen(
              verificationId: verificationId,
              email: emailController.text,
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (e) {
        utils().toastMessage(e.toString());
      },
    );
  }
}
