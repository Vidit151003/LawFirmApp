
import 'package:app1/post/add_post.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  return ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(snapshot.child('email').value.toString()),
                  );
                }),
          ),
          FloatingActionButton(
            onPressed: () {
              // Check if the user is logged in
              if (auth.currentUser != null) {
                // User is logged in, you can navigate to another screen or perform an action
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddPostScreen()));
              }
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
