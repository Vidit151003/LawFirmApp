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
      body: StreamBuilder<User?>(
        stream: ref.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data != null) {
            // Use FutureBuilder to properly await the async findRole()
            return FutureBuilder<String>(
              future: findRole(),
              builder: (context, roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final role = roleSnapshot.data ?? '';
                if (role == "client") {
                  return const ClientDashboard();
                } else if (role == "lawyer") {
                  return const LawyerDashboard();
                } else if (role == "authority") {
                  return const AuthorityDashboard();
                } else {
                  if (role.isNotEmpty) {
                    utils().toastMessage('Unknown role: $role');
                  }
                  return const WelcomePage();
                }
              },
            );
          } else {
            return const WelcomePage();
          }
        },
      ),
    );
  }

  Future<String> findRole() async {
    final uid = ref.currentUser?.uid;
    if (uid == null) return '';

    try {
      // Check clients collection (keyed by email or uid)
      final email = ref.currentUser?.email ?? '';

      // Try by email first (how sign-up stores it)
      DocumentSnapshot docByEmail;
      DocumentSnapshot docByEmail2;
      DocumentSnapshot docByEmail3;

      docByEmail = await _firestore.collection("clients").doc(email).get();
      if (docByEmail.exists) return "client";

      docByEmail2 = await _firestore.collection("lawyers").doc(email).get();
      if (docByEmail2.exists) return "lawyer";

      docByEmail3 = await _firestore.collection("authorities").doc(email).get();
      if (docByEmail3.exists) return "authority";

      // Also check by UID as fallback (for phone login)
      final clientsQuery = await _firestore
          .collection("clients")
          .where("uid", isEqualTo: uid)
          .limit(1)
          .get();
      if (clientsQuery.docs.isNotEmpty) return "client";

      final lawyersQuery = await _firestore
          .collection("lawyers")
          .where("uid", isEqualTo: uid)
          .limit(1)
          .get();
      if (lawyersQuery.docs.isNotEmpty) return "lawyer";

      final authoritiesQuery = await _firestore
          .collection("authorities")
          .where("uid", isEqualTo: uid)
          .limit(1)
          .get();
      if (authoritiesQuery.docs.isNotEmpty) return "authority";

    } catch (e) {
      utils().toastMessage('Error finding role: $e');
    }
    return '';
  }
}
