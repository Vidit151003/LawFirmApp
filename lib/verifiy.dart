// import 'package:app1/client_dahboard.dart';
// import 'package:app1/utils.dart';
// import 'package:app1/widgets/widgets.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class verifyscreen extends StatefulWidget {
//   final String verificationId;

//   const verifyscreen({super.key, required this.verificationId});

//   @override
//   State<verifyscreen> createState() => _verifyscreenState();
// }

// class _verifyscreenState extends State<verifyscreen> {
//   bool loading = false;

//   final phoneCodeController = TextEditingController();
//   final auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Color.fromRGBO(0, 65, 120, 1),
//         body: Center(
//             child: SingleChildScrollView(
//                 padding: EdgeInsets.all(32),
//                 child: Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Container(
//                         height: 280,
//                         width: 500,
//                         decoration: const BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color.fromRGBO(0, 65, 120, 0.2),
//                               spreadRadius: 6,
//                               blurRadius: 10,
//                               offset: Offset(0, 3),
//                             ),
//                           ],
//                           borderRadius: BorderRadius.all(Radius.circular(56)),
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.all(12.0),
//                           child: Center(
//                             child: Column(
//                               children: [
//                                 SizedBox(
//                                   height: 30,
//                                 ),
//                                 Text(
//                                   "Verify",
//                                   style: TextStyle(
//                                       fontFamily: "Kadwa",
//                                       fontStyle: FontStyle.italic,
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 SizedBox(height: 32),
//                                 TextField(
//                                   controller: phoneCodeController,
//                                   keyboardType: TextInputType.number,
//                                   decoration: InputDecoration(
//                                     labelText: '6 digit otp',
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(35),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 16),
//                                 OvalButtonSmall(
//                                   name: "Login",
//                                   onPressed: () async {
//                                     final credital =
//                                         PhoneAuthProvider.credential(
//                                             verificationId:
//                                                 widget.verificationId,
//                                             smsCode: phoneCodeController.text
//                                                 .toString());
//                                     try {
//                                       await auth.signInWithCredential(credital);
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 ClientDashboard(),
//                                           ));
//                                     } catch (e) {
//                                       utils().toastMessage(e.toString());
//                                     }

//                                     // Add your logic to get OTP here
//                                     // You can use the phoneNumberController.text to get the entered phone number
//                                   },
//                                 )
//                               ],
//                             ),
//                           ),
//                         ))))));
//   }
// }
import 'package:app1/client_dahboard.dart';
import 'package:app1/utils.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  final String verificationId;

  const VerifyScreen({super.key, required this.verificationId});

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
                            final credential = PhoneAuthProvider.credential(
                              verificationId: widget.verificationId,
                              smsCode: phoneCodeController.text.toString(),
                            );
                            try {
                              await auth.signInWithCredential(credential);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ClientDashboard(),
                                ),
                              );
                            } catch (e) {
                              utils().toastMessage(e.toString());
                            }
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
}
