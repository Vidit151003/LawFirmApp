import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  final String requestId;
  final String assignedLawyerUid;

  const LawyerDropDown({super.key, required this.requestId, this.assignedLawyerUid = ''});

  @override
  State<LawyerDropDown> createState() => _LawyerDropDownState();
}

class _LawyerDropDownState extends State<LawyerDropDown> {
  String? selectedLawyer;

  @override
  void initState() {
    super.initState();
    selectedLawyer = widget.assignedLawyerUid.isEmpty ? null : widget.assignedLawyerUid;
  }

  @override
  Widget build(BuildContext context) {
     return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('lawyers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2));
          }

          List<DropdownMenuItem<String>> lawyerItems = [];
          lawyerItems.add(
              const DropdownMenuItem(value: null, child: Text("Assign Lawyer")));
          
          if (snapshot.hasData) {
            var lawyers = snapshot.data!.docs;
            for (var lawyer in lawyers) {
              final data = lawyer.data() as Map<String, dynamic>?;
              if (data != null) {
                final uid = data['uid'] as String?;
                final name = data['name'] ?? "No name";
                
                // Only add to dropdown if they have a valid UID
                if (uid != null && uid.isNotEmpty) {
                  lawyerItems.add(DropdownMenuItem(
                    value: uid,
                    child: Text(name),
                  ));
                }
              }
            }
          }

          // Ensure selectedLawyer is actually in the list of items
          bool isValidSelection = lawyerItems.any((item) => item.value == selectedLawyer);
          if (!isValidSelection) {
            selectedLawyer = null;
          }

          return DropdownButton<String>(
            items: lawyerItems,
            onChanged: (lawyerUid) async {
              if (lawyerUid == null) return;
              
              setState(() {
                selectedLawyer = lawyerUid;
              });

              try {
                // Find the name of the selected lawyer safely
                String lawyerName = 'Unknown Lawyer';
                if (snapshot.hasData) {
                  for (var doc in snapshot.data!.docs) {
                    final data = doc.data() as Map<String, dynamic>?;
                    if (data != null && data['uid'] == lawyerUid) {
                      lawyerName = data['name'] ?? 'Unknown Lawyer';
                      break;
                    }
                  }
                }

                await FirebaseFirestore.instance
                    .collection('requests')
                    .doc(widget.requestId)
                    .update({
                  'assignedLawyerUid': lawyerUid,
                  'assignedLawyerName': lawyerName,
                  'status': 'assigned'
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Lawyer assigned successfully!')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error assigning lawyer: $e')),
                );
              }
            },
            value: selectedLawyer,
          );
        });
  }
}
