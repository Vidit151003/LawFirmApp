import 'package:app1/Screens/registeruser.dart';
import 'package:app1/Screens/welcome_page.dart';
import 'package:app1/screens/UserMessageScreen.dart';
import 'package:app1/screens/progressindigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// class LawyerDashboard extends StatelessWidget {
//   const LawyerDashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Lawyer Dashboard")),
//       body: const SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.all(15.0),
//             child: Center(
//               child: Text("This is Lawyer Dashboard"),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           SizedBox(
//             width: 200,
//             height: 60,
//             child: ElevatedButton(
//               onPressed: () {
//                 // Navigate to the progress screen
//                 // Add navigation to ProgressPage
//               },
//               child: const Text(
//                 'Progress',
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//           ),
//           SizedBox(height: 20), // Adding space between buttons
//           SizedBox(
//             width: 200,
//             height: 60,
//             child: ElevatedButton(
//               onPressed: () {
//                 // Navigate to the chat screen
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const WelcomePage(),
//                   ),
//                 );
//               },
//               child: const Text(
//                 'Chat',
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }
// Import necessary packages and libraries

class LawyerDashboard extends StatelessWidget {
  const LawyerDashboard({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lawyer Dashboard")),
      body: const SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(
              child: Text("This is Lawyer Dashboard"),
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 200,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the screen to display list of clients
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClientListScreen(),
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
                      Text("Progress",style: TextStyle(fontSize: 20,color: Colors.white)),
                      Expanded(child: SizedBox()),
                      Icon(Icons.incomplete_circle,color: Colors.white,),
                    ],
                  ),
                )
            ),
          ),
          SizedBox(height: 20), // Adding space between buttons
          SizedBox(
            width: 200,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the chat screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatRoomsScreen(userId: FirebaseAuth.instance.currentUser!.uid.toString()),
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
                      Text("Chat",style: TextStyle(fontSize: 20,color: Colors.white)),
                      Expanded(child: SizedBox()),
                      Icon(Icons.message_outlined,color: Colors.white,),
                    ],
                  ),
                )
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ClientListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Client List")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('clients').orderBy('email', descending:false).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator()); // Display a loading indicator while data is loading
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) {

              final clientData = doc.data() as Map<String, dynamic>?; // Nullable map
              if (clientData == null) return SizedBox(); // Skip if clientData is null
              return ListTile(
                leading: CircleAvatar(child: Text(clientData['email'].toString().substring(0,1).toUpperCase()) ,),
                title: Text(clientData['email'] ?? 'No Email'), // Use email if available, else use empty string
                onTap: () {
                  // Navigate to petitions screen with client ID as parameter
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PetitionsScreen(clientId: doc.id),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}



class PetitionsScreen extends StatelessWidget {
  final String clientId;

  const PetitionsScreen({required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Petitions")),
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
                  onTap: () {
                    // Navigate to progress update screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProgressUpdateScreen(
                          petitionId: doc.id,
                          petitionData: requestData,
                          clientId: clientId,
                        ),
                      ),
                    );
                  },
                  title: Text(requestData['subject'] ?? '',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status: ${requestData['status'] ?? ''}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),// Display status
                      Text('Description: ${requestData['description'] ?? ''}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
                      Text('Field: ${requestData['field'] ?? ''}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
                  ]
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
