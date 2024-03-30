import 'package:app1/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final CollectionReference postsCollection =
  FirebaseFirestore.instance.collection('posts');
  final postController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  String selectedRole = 'Client'; // Default role is Client
  late User? user; // Firebase User object

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 34),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Enter your name',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              hintText: 'Enter your email',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: phoneController,
            decoration: const InputDecoration(
              hintText: 'Enter your phone number',
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: selectedRole,
            onChanged: (String? newValue) {
              setState(() {
                selectedRole = newValue!;
              });
            },
            items: ['Client', 'Admin']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),

          const SizedBox(height: 34),
          OvalButton(
            name: 'Add',
            onPressed: () async {
              if (user != null) {
                String postId = user!.uid;

                await postsCollection.doc(postId).set({
                  'name': nameController.text,
                  'email': emailController.text,
                  'phone': phoneController.text,
                  'role': selectedRole,
                  'id': postId,
                }).then((value) {
                  utils().toastMessage('Post added');
                  // Do something after the data is saved
                }).catchError((error) {
                  utils().toastMessage(error.toString());
                });
              } else {
                utils().toastMessage('User not authenticated');
              }
            },
          ),
        ],
      ),
    );
  }
}