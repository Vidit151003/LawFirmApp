
import 'dart:html';

import 'package:app1/Screens/registeruser.dart';
import 'package:app1/Screens/welcome_page.dart';
import 'package:app1/screens/UserMessageScreen.dart';
import 'package:app1/screens/client_request_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Screens/add_authority.dart';
import '../Screens/add_lawyer.dart';

class AuthorityDashboard extends StatelessWidget {
  const AuthorityDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(title: const Text("Authority Dashboard")),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    const SizedBox(height: 20,),
                    Container(
                      height: 80,
                      width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddLawyer(),
                              ),
                            );
                          },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(0, 65, 120, 1),
                              elevation: 20.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                          child: Container(
                            height: 60,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Add Lawyer",style: TextStyle(fontSize: 20,color: Colors.white)),
                                Expanded(child: SizedBox()),
                                Icon(Icons.person_add_alt_1_rounded,color: Colors.white,),
                              ],
                            ),
                          )
                        ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: 80,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddAuthority(),
                            ),
                          );
                        },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(0, 65, 120, 1),
                            elevation: 20.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          child: Container(
                            height: 60,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Add Authority",style: TextStyle(fontSize: 20,color: Colors.white)),
                                Expanded(child: SizedBox()),
                                Icon(Icons.person_add_alt,color: Colors.white,),
                              ],
                            ),
                          )
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: 80,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatRoomsScreen(userId: FirebaseAuth.instance.currentUser!.uid),
                            ),
                          );
                        },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(0, 65, 120, 1),
                            elevation: 20.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          child: Container(
                            height: 60,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Open Chat",style: TextStyle(fontSize: 20,color: Colors.white)),
                                Expanded(child: SizedBox()),
                                Icon(Icons.chat_bubble_rounded,color: Colors.white,),
                              ],
                            ),
                          )
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: 80,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to ViewRegisteredUsersScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewRegisteredUsersScreen(viewer: FirebaseAuth.instance.currentUser?.uid.toString()),
                            ),
                          );
                        },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(0, 65, 120, 1),
                            elevation: 20.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          child: Container(
                            height: 60,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("View Registered Users",style: TextStyle(fontSize: 20,color: Colors.white)),
                                Expanded(child: SizedBox()),
                                Icon(Icons.person,color: Colors.white,),
                              ],
                            ),
                          )
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: 80,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to ChatManagementScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => client_request_screen(),
                            ),
                          );
                        },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(0, 65, 120, 1),
                            elevation: 20.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          child: Container(
                            height: 60,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Chat Management",style: TextStyle(fontSize: 20,color: Colors.white)),
                                Expanded(child: SizedBox()),
                                Icon(Icons.settings,color: Colors.white,),
                              ],
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
