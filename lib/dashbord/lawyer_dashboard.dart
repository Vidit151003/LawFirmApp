// import 'package:app1/chat/chat.dart';
// import 'package:flutter/material.dart';



// class LawyerDashboard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Lawyer Dashboard")),
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
//       floatingActionButton: Container(
//         width: 200,
//         height: 60,
//         child: ElevatedButton(
//           onPressed: () {
//             // Navigate to the chat screen
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ChatScreen(roomID: 'roomID'),
//               ),
//             );
//           },
//           child: const Text(
//             'Chat',
//             style: TextStyle(fontSize: 20),
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }
import 'package:app1/Screens/welcome_page.dart';
import 'package:flutter/material.dart';
// Import ChatScreen

class LawyerDashboard extends StatelessWidget {
  const LawyerDashboard({super.key});

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
      floatingActionButton: SizedBox(
        width: 200,
        height: 60,
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the chat screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WelcomePage(),
              ),
            );
          },
          child: const Text(
            'Chat',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
