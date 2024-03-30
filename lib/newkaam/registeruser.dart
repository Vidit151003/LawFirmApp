import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewRegisteredUsersScreen extends StatelessWidget {
  const ViewRegisteredUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registered Users"),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildUserList('clients'),
          ),
          Expanded(
            child: _buildUserList('lawyers'),
          ),
          Expanded(
            child: _buildUserList('authorities'),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList(String collection) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection(collection).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final users = snapshot.data!.docs;

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
            final user = users[index].data() as Map<String, dynamic>;
            // Assuming you have 'email' field in each document
            final email = user['email'] ?? 'No Email'; // Handling null value
            return ListTile(
              title: Text(email),
              // Add more fields if needed
            );
          },
        );
      },
    );
  }
}
