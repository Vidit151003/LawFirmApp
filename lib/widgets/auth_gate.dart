import 'dart:html';

import 'package:app1/Screens/welcome_page.dart';
import 'package:app1/dashbord/authority_dashboard.dart';
import 'package:app1/dashbord/client_dashboard.dart';
import 'package:app1/dashbord/lawyer_dashboard.dart';
import 'package:app1/widgets/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth_Gate extends StatelessWidget {
  Auth_Gate({super.key});

  final ref = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: ref.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Future.delayed(Duration(seconds: 4));
            String role = findRole().toString();
            Future.delayed(Duration(seconds: 2));
            if (role == "client") {
              return ClientDashboard();
            } else if (role == "lawyer") {
              return LawyerDashboard();
            } else if (role == "authority") {
              return AuthorityDashboard();
            } else {
              utils().toastMessage(role.toString());
              return WelcomePage();
            }
          } else {
            return WelcomePage();
          }
        },
      ),
    );
  }

  /* String findRole() async {
    DocumentSnapshot? documentSnapshot1;
    DocumentSnapshot? documentSnapshot2;
    DocumentSnapshot? documentSnapshot3;
    await _firestore
        .collection("clients")
        .doc(ref.currentUser!.toString())
        .get()
        .then((value) {
      documentSnapshot1 = value;
    });
    await _firestore
        .collection("lawyers")
        .doc(ref.currentUser!.toString())
        .get()
        .then((value) {
      documentSnapshot2 = value;
    });
    await _firestore
        .collection("authorities")
        .doc(ref.currentUser!.toString())
        .get()
        .then((value) {
      documentSnapshot3 = value;
    });
    if (documentSnapshot1!.exists ) {
      return "client";
    } else if (documentSnapshot2!.exists) {
      return "lawyer";
    } else if (documentSnapshot3!.exists) {
      return "authority";
    } else {
      return "";
    }
  }*/

  Future<String> findRole() async {
    DocumentSnapshot? documentSnapshot1;
    DocumentSnapshot? documentSnapshot2;
    DocumentSnapshot? documentSnapshot3;

    try {
      documentSnapshot1 = await _firestore
          .collection("clients")
          .doc(ref.currentUser!.toString())
          .get();
    } catch (_) {
      documentSnapshot1 = null;
    }

    try {
      documentSnapshot2 = await _firestore
          .collection("lawyers")
          .doc(ref.currentUser!.toString())
          .get();
    } catch (_) {
      documentSnapshot2 = null;
    }

    try {
      documentSnapshot3 = await _firestore
          .collection("authorities")
          .doc(ref.currentUser!.toString())
          .get();
    } catch (_) {
      documentSnapshot3 = null;
    }

    if (documentSnapshot1?.exists ?? false) {
      return "client";
    } else if (documentSnapshot2?.exists ?? false) {
      return "lawyer";
    } else if (documentSnapshot3?.exists ?? false) {
      return "authority";
    } else {
      return "";
    }
  } 
}
