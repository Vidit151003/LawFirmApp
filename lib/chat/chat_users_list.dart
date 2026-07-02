import 'package:app1/chat/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatUsersList extends StatelessWidget {
  final String userRole; // 'client' or 'lawyer'

  const ChatUsersList({super.key, required this.userRole});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Chats")),
        body: const Center(child: Text("Not logged in.")),
      );
    }

    Query query;
    if (userRole == 'client') {
      // Clients see petitions where they are the owner and a lawyer is assigned
      query = FirebaseFirestore.instance
          .collection('requests')
          .where('uid', isEqualTo: user.uid)
          .where('status', isEqualTo: 'assigned');
    } else {
      // Lawyers see petitions where they are the assigned lawyer
      query = FirebaseFirestore.instance
          .collection('requests')
          .where('assignedLawyerUid', isEqualTo: user.uid);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Chats"),
        backgroundColor: const Color.fromRGBO(0, 65, 120, 1),
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: query.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          
          final requests = snapshot.data?.docs ?? [];
          if (requests.isEmpty) {
            return const Center(child: Text("No assigned chats yet."));
          }

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index].data() as Map<String, dynamic>? ?? {};
              
              String displayName = '';
              String targetUid = '';

              if (userRole == 'client') {
                displayName = request['assignedLawyerName'] ?? 'Unknown Lawyer';
                targetUid = request['assignedLawyerUid'] ?? '';
              } else {
                displayName = request['name'] ?? 'Unknown Client';
                targetUid = request['uid'] ?? '';
              }

              final subject = request['subject'] ?? 'No Subject';

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color.fromRGBO(0, 65, 120, 1),
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(displayName, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("Subject: $subject"),
                  trailing: const Icon(Icons.chat_bubble_outline),
                  onTap: () {
                    if (targetUid.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            receiverUserId: targetUid,
                            senderUserId: user.uid,
                            receiverName: displayName,
                          ),
                        ),
                      );
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
