import 'package:app1/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class client_request_screen extends StatelessWidget {
  const client_request_screen({super.key});

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
            final requestDoc = requests[index];
            final request = requestDoc.data() as Map<String, dynamic>? ?? {};
            final subject = request['subject'] ?? 'No Subject';
            final name = request['name'] ?? 'Unknown Client';
            final description = request['description'] ?? 'No Description';
            final assignedLawyerUid = request['assignedLawyerUid'] ?? '';
            final status = request['status'] ?? 'pending';

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ListTile(
                title: Text("$name: $subject"),
                subtitle: Text("Status: $status\n$description"),
                isThreeLine: true,
                trailing: LawyerDropDown(
                  requestId: requestDoc.id,
                  assignedLawyerUid: assignedLawyerUid,
                ),
              ),
            );
          },
        );
      },
    );
  }

  /*Widget selectLawyer(String clientId) {
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
                  child: Text(lawyer['name']),
                ));
                uid = lawyer['uid'];
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
                            receiverUserId: uid,
                            senderUserId: clientId.toString(),
                          )),
                );
              },
              value: selectedLawyer,
            );
          })
    ]);
  }*/
}
