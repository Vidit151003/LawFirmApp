import 'package:app1/chat/chat.dart';
import 'package:app1/Screens/welcome_page.dart';
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
                        MaterialPageRoute(builder: (context) => const WelcomePage()),
                      ),
                      child: SizedBox(
                          height:165,
                          width: 140,
                          child: Center(child: Image.asset('assets/images/Petition.png'))),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const WelcomePage()),
                      ),
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
                        MaterialPageRoute(builder: (context) => const ChatScreen(currentUserID: 'currentUserID', chatUserID: 'chatUserID')),
                      ),
                      child: SizedBox(
                          height:165,
                          width: 135,
                          child: Image.asset('assets/images/img.png')),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const WelcomePage()),
                      ),
                      child: SizedBox(
                        height:163,
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

