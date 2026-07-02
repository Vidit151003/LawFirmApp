import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

Future<void> seedAdmin() async {
  try {
    var auth = FirebaseAuth.instance;
    var firestore = FirebaseFirestore.instance;
    
    // 1. Try to create the admin user
    try {
      await auth.createUserWithEmailAndPassword(
        email: "vidit@gmail.com", 
        password: "123456"
      );
      debugPrint("Admin user created in Firebase Auth.");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        debugPrint("Admin user already exists in Auth, proceeding to seed Firestore...");
      } else {
        debugPrint("Failed to create user: ${e.message}");
        return;
      }
    }
    
    // 2. Sign in as the admin to ensure we have permission to write to Firestore
    // (Depending on your security rules, you might need to be authenticated to write)
    await auth.signInWithEmailAndPassword(
      email: "vidit@gmail.com", 
      password: "123456"
    );
    
    var user = auth.currentUser;
    if (user != null) {
      // 3. Write the admin (authority) role to Firestore
      await firestore.collection("authorities").doc("vidit@gmail.com").set({
        'uid': user.uid,
        'role': 'authority',
        'email': 'vidit@gmail.com',
        'ids': DateTime.now().millisecondsSinceEpoch.toString(),
      }, SetOptions(merge: true));
      
      debugPrint("Admin role successfully seeded in Firestore under 'authorities' collection!");
    }

    // 4. Sign out so the user can log in normally via the UI
    await auth.signOut();
  } catch (e) {
    debugPrint("An error occurred while seeding the admin: $e");
  }
}
