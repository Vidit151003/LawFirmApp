
import 'package:app1/widgets/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../chat/chat_page.dart';

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


class LawyerDropDown extends StatefulWidget {
  const LawyerDropDown({super.key, required this.clientId, required this.clientemail, required this.subject});
  final String clientId;
  final String clientemail;
  final String subject;

  @override
  _LawyerDropDownState createState() => _LawyerDropDownState();
}

class _LawyerDropDownState extends State<LawyerDropDown> {
  String? selectedLawyer; // Stores the selected lawyer's ID
  String? uid;
  final _firestore = FirebaseFirestore.instance.collection('requests'); // Firestore reference

  @override
  void initState() {
    super.initState();
    _loadAssignedLawyer();
  }

  Future<void> _loadAssignedLawyer() async {
    String? lawyer = await getAssignedLawyer(widget.clientemail.toString(), widget.subject.toString());
    setState(() {
      selectedLawyer = lawyer; // Set the initial value for the dropdown
    });
  }

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
          const DropdownMenuItem<String>(value: null, child: Text("Assign Lawyer")),
          ...lawyers.map((lawyer) {
            return DropdownMenuItem<String>(
              value: lawyer.id,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 200), // Prevents long text overflow
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Allows scrolling for long names
                  child: Text(
                    lawyer['email'] ?? "No email",
                    overflow: TextOverflow.ellipsis, // Truncates long text
                    softWrap: false,
                  ),
                ),
              ),
            );
          }),
        ];

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.transparent,
          ),
          child: SizedBox(
            height: 50,
            width: 250,
            child: DropdownButtonFormField<String>(
              items: lawyerItems,
              value: selectedLawyer,
              hint: const Text("Select a Lawyer"),
              menuMaxHeight: 300, // Prevents dropdown from taking the entire screen
              onChanged: (lawyerId) {
                setState(() {
                  selectedLawyer = lawyerId;

                  var ids = [widget.clientemail.toString(), widget.subject.toString()];
                  var docId = ids.join("_");

                  // Update only the assignedLawyer field using update()
                  _firestore.doc(docId).update({'assignedLawyer': lawyerId}); // Update selected lawyer

                  if (lawyerId != null) {
                    var lawyerDoc = lawyers.firstWhere((lawyer) => lawyer.id == lawyerId);
                    uid = lawyerDoc['uid']; // Retrieve UID of the selected lawyer

                    // Navigate to ChatPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          receiverUserId: widget.clientId.toString(),
                          senderUserId: uid!.toString(),
                        ),
                      ),
                    );
                  }
                });
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                border: InputBorder.none,
              ),
            ),
          ),
        );
      },
    );
  }
}

Future<String?> getAssignedLawyer(String clientEmail, String subject) async {
  try {
    // Create the document ID from clientEmail and subject
    var docId = "${clientEmail.toString()}_$subject";

    // Fetch the document using the generated docId
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('requests')
        .doc(docId) // Use the generated document ID
        .get();

    // Check if the document exists
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      return data['assignedLawyer'] != null ? data['assignedLawyer'] as String : null;
    }

    return null; // Document not found
  } catch (e) {
    utils().toastMessage('Error fetching assigned lawyer: $e');
    return null;
  }
}
