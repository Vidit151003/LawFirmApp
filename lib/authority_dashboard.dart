import 'package:app1/add_authority.dart';
import 'package:app1/add_lawyer.dart';

import 'package:flutter/material.dart';


/*class ClientDashboard extends StatefulWidget {
  @override
  _ClientDashboardState createState() => _ClientDashboardState();
}

class _ClientDashboardState extends State<ClientDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              "Welcome",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildBookingCard("View Your Applications", ""),
                _buildBookingCard("New Application", ""),
                _buildBookingCard("ChatBox", ""),
                _buildBookingCard("Contact Us","")
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(String title, String subtitle) {
    return Card(
      color: Colors.blue,
      margin: EdgeInsets.all(16),
      child: InkWell(
        onTap: () {
          utils().toastMessage("The button was pressed");
        },
        child: Container(
          padding: EdgeInsets.all(25),
          child: Stack(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(subtitle),
            ],
          ),
        ),
      ),
    );
  }
}*/


class AuthorityDashboard extends StatelessWidget {
  const AuthorityDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
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
                      const SizedBox(height: 200,),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddLawyer(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add_box, size: 65,shadows:[Shadow(color: Colors.grey,blurRadius: 30)],)),
                   const Text("Add Lawyer",style: TextStyle(fontSize: 20),),

                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddAuthority(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.person_add_alt_1_sharp, size: 65,shadows:[Shadow(color: Colors.grey,blurRadius: 30)],)),
                      const Text("Add Authority",style: TextStyle(fontSize: 20),),
                      ]))
            ),
          ),
        ),
      ),
    );

  }
}