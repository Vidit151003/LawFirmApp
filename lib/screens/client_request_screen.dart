import 'package:app1/chat/chat_page.dart';
import 'package:app1/screens/request_description_page.dart';
import 'package:app1/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientRequestScreen extends StatelessWidget {
  const ClientRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Requests"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: _buildUserList(),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('requests').orderBy('timestamp', descending: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final requests = snapshot.data!.docs;

        return ListView.builder(
          itemCount: requests.length,
          itemBuilder: (BuildContext context, int index) {
            final request = requests[index].data() as Map<String, dynamic>;
            final email = request['email'] ?? 'No email';
            final subject = request['subject'] ?? 'No Subject';
            final uid = request['uid'] ?? 'No UID';
            final description = request['description'] ?? 'No Description';
            final field =request['field'] ?? 'No Field';

            return GestureDetector(
              onTap: () {
                // Trigger when tapping outside the dropdown
                var adminuid = FirebaseAuth.instance.currentUser!.uid;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RequestDescriptionPage(clientEmail: email, subject: subject, clientId: uid,),
                  ),
                );
              },
              behavior: HitTestBehavior.opaque, // Ensures taps outside dropdown are detected
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$email: $subject",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(field, style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                    Text(description, style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                    LawyerDropDown(clientId: uid, clientemail: email, subject: subject,),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
