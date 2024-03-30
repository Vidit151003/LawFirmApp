
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


class LawyerDashbaord extends StatelessWidget {
  const LawyerDashbaord({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Scaffold(
        appBar: AppBar(title: const Text("Lawyer Dashbaord")),
        body: const SingleChildScrollView(
          child: SafeArea(
            child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(child: Text("This is Lawyer Dashboard"))
            ),
          ),
        ),
      ),
    );

  }
}