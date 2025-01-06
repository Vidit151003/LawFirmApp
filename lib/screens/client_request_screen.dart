import 'package:app1/chat/chat_page.dart';
import 'package:app1/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class client_request_screen extends StatelessWidget {
   client_request_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Requests"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: _buildUserList(),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('requests').snapshots(),
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

        final requests = snapshot.data!.docs;

        return ListView.builder(
          itemCount: requests.length,
          itemBuilder: (BuildContext context, int index) {
            final request = requests[index].data() as Map<String, dynamic>;
            // Assuming you have 'email' field in each document
            final email= request['email']??'No email';
            final subject =
                request['subject'] ?? 'No Subject'; // Handling null value// Handling null value
            final uid = request['uid'] ?? 'No UID'; // Handling null value
            final description = request['description'] ??
                'No Description'; // Handling null value
            return ListTile(
                title: Text(email +":"+subject),
                focusNode: FocusNode(debugLabel: description),
                trailing: LawyerDropDown(clientId: uid,),
                onTap: () {
                  LawyerDropDown(clientId: uid,);
                },
                // Add more fields if needed
                );
          },
        );
      },
    );
  }

  Widget selectLawyer(String clientId) {
    var selectedLawyer = 0;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start, children: [
      StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('lawyers').snapshots(),
          builder: (context, snapshot) {
            List<DropdownMenuItem> lawyerItems = [];
            var uid;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              final lawyers = snapshot.data?.docs.toList();
              lawyerItems.add(
                  DropdownMenuItem(value: 0, child: Text("Assign Lawyer")));
              for (var lawyer in lawyers!) {
                lawyerItems.add(DropdownMenuItem(
                  value: lawyer.id,
                  child: Text(lawyer['name']??'No Name'),
                ));
                uid = lawyer['uid']??'No UID';
              }
            }
            return DropdownButton(
              items: lawyerItems,
              onChanged: (lawyervalue) {
                selectedLawyer = lawyervalue;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatPage(
                            receiverUserId: clientId.toString(),
                            senderUserId: uid.toString(),
                          )),
                );
              },
              value: selectedLawyer,
            );
          })
    ]);
  }
}
