import 'package:app1/screens/UserMessageScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app1/screens/servicerequest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientDashboard extends StatelessWidget {
  final String userEmail; // Add this field to hold the user's email

  const ClientDashboard({super.key, required this.userEmail});

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
    MaterialPageRoute(
      builder: (context) => PetitionProgressScreen(
        clientId: FirebaseAuth.instance.currentUser!.uid, // Use UID instead of email
      ),
    ),
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

  const PetitionProgressScreen({super.key, required this.clientId});

  @override
Widget build(BuildContext context) {
  print('Fetching requests for clientId: $clientId'); // Debug log

  return Scaffold(
    appBar: AppBar(
      title: const Text("Petition Progress"),
    ),
    body: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('clients')
          .doc(clientId)
          .collection('requests')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          print('Error fetching requests: ${snapshot.error}'); // Debug log
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.data!.docs.isEmpty) {
          print('No requests found for clientId: $clientId'); // Debug log
          return const Center(child: Text('No petitions found.'));
        }

        print('Requests found: ${snapshot.data!.docs.length}'); // Debug log
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          itemCount: snapshot.data!.docs.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final requestData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
            print('Request Data: $requestData'); // Debug log
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(
                  requestData['subject'] ?? '',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Status: ${requestData['status'] ?? ''}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    Text('Description: ${requestData['description'] ?? ''}', style: const TextStyle(fontSize: 12)),
                    Text('Field: ${requestData['field'] ?? ''}', style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            );
          },
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
