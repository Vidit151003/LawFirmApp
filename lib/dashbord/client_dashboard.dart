import 'package:app1/screens/UserMessageScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app1/Screens/registeruser.dart';
import 'package:app1/Screens/welcome_page.dart';
import 'package:app1/screens/servicerequest.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientDashboard extends StatelessWidget {
  final String userEmail; // Add this field to hold the user's email

  const ClientDashboard({Key? key, required this.userEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const SizedBox(height: 100),
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
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ServiceRequestPage(userEmail: userEmail)),
                        );
                      },
                      child: SizedBox(
                          height: 165,
                          width: 140,
                          child: Center(child: Image.asset('assets/images/Petition.png'))),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PetitionProgressScreen(clientId: userEmail)),//show the client petitons and the progress kndiator here
                      ),
                      child: SizedBox(
                        height: 165,
                        width: 135,
                        child: Image.asset('assets/images/Review Petition.png'),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatRoomsScreen( userId: FirebaseAuth.instance.currentUser!.uid,)),
                      ),
                      child: SizedBox(
                          height: 165,
                          width: 135,
                          child: Image.asset('assets/images/img.png')),
                    ),
                    InkWell(
                      onTap: _launchURL,
                      child: SizedBox(
                        height: 163,
                        width: 130,
                        child: Image.asset('assets/images/Contact Us.png'),
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



class PetitionProgressScreen extends StatelessWidget {
  final String clientId;

  const PetitionProgressScreen({required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Petition Progress"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('clients')
            .doc(clientId)
            .collection('requests')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              final requestData = doc.data() as Map<String, dynamic>;
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(requestData['subject'] ?? '', style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status: ${requestData['status'] ?? ''}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)), // Display status
                      Text('Description: ${requestData['description'] ?? ''}', style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
                      Text('Field: ${requestData['field'] ?? ''}', style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

_launchURL() {
  Uri.parse('https://flutter.dev');
  mode: LaunchMode.externalApplication;
  }
