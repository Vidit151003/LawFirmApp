import 'package:app1/widgets/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../chat/chat_page.dart';
import '../dashbord/authority_dashboard.dart';
import '../dashbord/client_dashboard.dart';
import '../dashbord/lawyer_dashboard.dart';

class OvalButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  final bool loading;

  const OvalButton({
    super.key,
    required this.name,
    required this.onPressed,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      width: 280,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(0, 65, 120, 1),
          ),
          child: Center(
              child: loading
                  ? const CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.white,
                    )
                  : Text(name,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20)))),
    );
  }
}

class OvalButtonWithIcon extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  final bool loading;
  final IconData icon;
  final Color color;

  const OvalButtonWithIcon({
    super.key,
    required this.name,
    required this.onPressed,
    this.loading = false,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      width: 280,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(0, 65, 120, 1),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: color,
              ),
              const SizedBox(
                width: 10,
              ),
              Center(
                  child: loading
                      ? const CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.white,
                        )
                      : Text(name,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20))),
            ],
          )),
    );
  }
}

class OvalButtonSmall extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  final bool loading;

  const OvalButtonSmall({
    super.key,
    required this.name,
    required this.onPressed,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 150,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(0, 65, 120, 1),
          ),
          child: Center(
              child: loading
                  ? const CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.white,
                    )
                  : Text(name,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 18)))),
    );
  }
}

class OvalButtonColor extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  final bool loading;
  final Color color1;

  const OvalButtonColor({
    super.key,
    required this.name,
    required this.onPressed,
    this.loading = false,
    required this.color1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      width: 150,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color1,
          ),
          child: Center(
              child: loading
                  ? const CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.white,
                    )
                  : Text(name,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20)))),
    );
  }
}

/*

class BuildUserList extends StatelessWidget {
  final Ontap;
  final String collection;
  const BuildUserList({super.key, required this.collection, required this.Ontap});

  @override
  Widget build(BuildContext context) {
    return _buildUserList(collection);
  }
*/

class LawyerDropDown extends StatefulWidget {
  const LawyerDropDown({super.key, required this.clientId});
  final String clientId;

  @override
  _LawyerDropDownState createState() => _LawyerDropDownState();
}

class _LawyerDropDownState extends State<LawyerDropDown> {
  String? selectedLawyer; // Stores the selected lawyer's ID
  String? uid; // Stores the UID of the selected lawyer

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('lawyers').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text("No lawyers available");
        }

        var lawyers = snapshot.data!.docs;

        // Build dropdown items
        List<DropdownMenuItem<String>> lawyerItems = [
          const DropdownMenuItem<String>(
            value: null,
            child: Text("Assign Lawyer"),
          ),
          ...lawyers.map((lawyer) {
            return DropdownMenuItem<String>(
              value: lawyer.id,
              child: Text(lawyer['email'] ?? "No email"),
            );
          }).toList(),
        ];

        return SizedBox(
          height: 100,
          width: 450,
          child: DropdownButton<String>(
            items: lawyerItems,
            value: selectedLawyer,
            hint: const Text("Select a Lawyer"),
            onChanged: (lawyerId) {
              setState(() {
                selectedLawyer = lawyerId; // Update selected lawyer
                if (lawyerId != null) {
                  var lawyerDoc =
                  lawyers.firstWhere((lawyer) => lawyer.id == lawyerId);
                  uid = lawyerDoc['uid']; // Retrieve UID of the selected lawyer

                  // Navigate to ChatPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(
                        receiverUserId: uid!,
                        senderUserId: widget.clientId,
                      ),
                    ),
                  );
                }
              });
            },
          ),
        );
      },
    );
  }
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
            final uid =user['uid'] ?? 'No UID'; // Handling null value
            return ListTile(
                title: Text(email),
                onTap: null,
              // Add more fields if needed
            );
          },
        );
      },
    );
  }

