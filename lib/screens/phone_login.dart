
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:app1/dashbord/client_dashboard.dart';
// import 'package:app1/widgets/utils.dart';

// class PhoneLogin extends StatefulWidget {
//   const PhoneLogin({Key? key}) : super(key: key);

//   @override
//   _PhoneLoginState createState() => _PhoneLoginState();
// }

// class _PhoneLoginState extends State<PhoneLogin> {
//   bool loading = false;

//   final TextEditingController emailController = TextEditingController();
//   final FirebaseAuth auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.blue,
//               Colors.white,
//               Colors.white,
//             ],
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 200),
//                   const Text(
//                     'Login',
//                     style: TextStyle(
//                       color: Color(0xFF182448),
//                       fontSize: 48,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 40),
//                   TextFormField(
//                     controller: emailController,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       labelText: 'Enter number here',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       signInWithPhone();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue.shade800,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 15, horizontal: 30),
//                     ),
//                     child: const Text(
//                       "Get OTP",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void signInWithPhone() async {
//     loading = true;
//     auth.verifyPhoneNumber(
//       phoneNumber: "+91${emailController.text}",
//       verificationCompleted: (_) {},
//       verificationFailed: (e) {
//         utils().toastMessage(e.toString());
//       },
//       codeSent: (String verificationId, int? token) {
//         loading = false;
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => VerifyScreen(
//               verificationId: verificationId,
//               email: emailController.text,
//             ),
//           ),
//         );
//       },
//       codeAutoRetrievalTimeout: (e) {
//         utils().toastMessage(e.toString());
//       },
//     );
//   }
// }

// class VerifyScreen extends StatefulWidget {
//   final String verificationId;
//   final String email;

//   const VerifyScreen({Key? key, required this.verificationId, required this.email}) : super(key: key);

//   @override
//   State<VerifyScreen> createState() => _VerifyScreenState();
// }

// class _VerifyScreenState extends State<VerifyScreen> {
//   bool loading = false;

//   final TextEditingController phoneCodeController = TextEditingController();
//   final FirebaseAuth auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.blue,
//               Colors.white,
//               Colors.white,
//             ],
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(32),
//             child: Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: Container(
//                 height: 280,
//                 width: 500,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color.fromRGBO(0, 65, 120, 0.2),
//                       spreadRadius: 6,
//                       blurRadius: 10,
//                       offset: Offset(0, 3),
//                     ),
//                   ],
//                   borderRadius: BorderRadius.all(Radius.circular(35)),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const SizedBox(
//                           height: 30,
//                         ),
//                         const Text(
//                           "Verify",
//                           style: TextStyle(
//                             fontFamily: "Kadwa",
//                             fontStyle: FontStyle.italic,
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         const SizedBox(height: 32),
//                         TextFormField(
//                           controller: phoneCodeController,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             labelText: '6 digit OTP',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(35),
//                             ),
//                             filled: true,
//                             fillColor: Colors.white,
//                             hintStyle: const TextStyle(color: Colors.grey),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         ElevatedButton(
//                           onPressed: () async {
//                             signInAndStoreDetails();
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(35),
//                             ),
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 15, horizontal: 30),
//                           ),
//                           child: const Text(
//                             "Login",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void signInAndStoreDetails() async {
//     final credential = PhoneAuthProvider.credential(
//       verificationId: widget.verificationId,
//       smsCode: phoneCodeController.text.toString(),
//     );

//     try {
//       await auth.signInWithCredential(credential);

//       // Navigate to ClientDashboard after successful login
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ClientDashboard(userEmail: widget.email),
//         ),
//       );
//     } catch (e) {
//       utils().toastMessage(e.toString());
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app1/dashbord/client_dashboard.dart';
import 'package:app1/widgets/utils.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key? key}) : super(key: key);

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  bool loading = false;

  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

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
                      signInWithPhone();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
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

  void signInWithPhone() async {
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

class VerifyScreen extends StatefulWidget {
  final String verificationId;
  final String email;

  const VerifyScreen({Key? key, required this.verificationId, required this.email}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  bool loading = false;

  final TextEditingController phoneCodeController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

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
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
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

      // Check if user details are provided
      DocumentSnapshot userDetails = await FirebaseFirestore.instance.collection('users').doc(widget.email).get();

      // Check if the document exists and if the field exists
      if (userDetails.exists && (userDetails.data() as Map<String, dynamic>).containsKey('detailsProvided') && (userDetails.data() as Map<String, dynamic>)['detailsProvided'] != null) {
        bool detailsProvided = (userDetails.data() as Map<String, dynamic>)['detailsProvided'];
        if (!detailsProvided) {
          // Navigate to UserDetailsPage if details are not provided
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetailsPage(userEmail: widget.email),
            ),
          );
        } else {
          // Navigate to Dashboard if details are provided
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ClientDashboard(userEmail: widget.email),
            ),
          );
        }
      } else {
        // If the field doesn't exist or the document doesn't exist, assume details are not provided
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => UserDetailsPage(userEmail: widget.email),
          ),
        );
      }
    } catch (e) {
      utils().toastMessage(e.toString());
    }
  }
}

class UserDetailsPage extends StatefulWidget {
  final String userEmail;

  const UserDetailsPage({Key? key, required this.userEmail}) : super(key: key);

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            TextFormField(
              controller: companyNameController,
              decoration: InputDecoration(labelText: 'Company Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                saveUserDetails();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void saveUserDetails() {
    // Get the values from text controllers
    String name = nameController.text.trim();
    int age = int.tryParse(ageController.text.trim()) ?? 0;
    String companyName = companyNameController.text.trim();

    // Add user details to Firestore
    firestore.collection('clients').doc(widget.userEmail).set({
      'name': name,
      'age': age,
      'companyName': companyName,
      'detailsProvided': true, // Assume details are provided after saving
    }).then((_) {
      // Navigate to Dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ClientDashboard(userEmail: widget.userEmail),
        ),
      );
    }).catchError((error) {
      // Handle error
      print('Error saving user details: $error');
    });
  }
}
