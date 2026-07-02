
import 'package:app1/Screens/registeruser.dart';
import 'package:app1/Screens/welcome_page.dart';
import 'package:app1/screens/send_request.dart';
import 'package:app1/chat/chat_users_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ClientDashboard extends StatelessWidget {
  const ClientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const SizedBox(height:100,),
                Container(
                  height: 80,
                  width: 80,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://ik.imagekit.io/upscale/wp-content/uploads/2022/09/cropped-favicon.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Welcome Client!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: "Kadwa"),
                  ),
                ),
                const SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Send_Request()),
                      ),
                      child: SizedBox(
                          height:165,
                          width: 140,
                          child: Center(child: Image.asset('assets/images/Petition.png'))),
                    ),
                    InkWell(
                      onTap: () {
                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Review Petition coming soon')));
                      },
                      child: SizedBox(
                        height:165,
                        width: 135,
                        child: Image.asset('assets/images/Review Petition.png'),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ChatUsersList(userRole: 'client')),
                      ),
                      child: SizedBox(
                          height:165,
                          width: 135,
                          child: Image.asset('assets/images/img.png')), // Assuming this is the Chat image
                    ),
                    InkWell(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const WelcomePage()),
                        );
                      },
                      child: SizedBox(
                        height:163,
                        width: 130,
                        child: Image.asset('assets/images/Contact Us.png'), // Will act as Logout
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
