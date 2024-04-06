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

class LawyerDropDown extends StatelessWidget {

  const LawyerDropDown({super.key, required this.clientId});
  final clientId;

  @override
  Widget build(BuildContext context) {
    var selectedLawyer = 0;
    var lawyers;
    var uid;
    var lawyer;
    List<DropdownMenuItem> lawyerItems = [];
     return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('lawyers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            lawyers = snapshot.data?.docs.toList();
            lawyerItems.add(
                DropdownMenuItem(value: 0, child: Text("Assign Lawyer")));
            for (lawyer in lawyers!) {
              lawyerItems.add(DropdownMenuItem(
                value: lawyer.id,
                child: Text(lawyer['name']?? "No name"),
              ));
              uid = lawyer['uid'];
            }
          }
          return DropdownButton(
            items: lawyerItems,
            onChanged: (lawyervalue) {
              //selectedLawyer = lawyervalue;
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ChatPage(
                          receiverUserId: uid,
                          senderUserId: clientId.toString(),
                        )),
              );
            },
            value: selectedLawyer,
          );
        });
  }
}
