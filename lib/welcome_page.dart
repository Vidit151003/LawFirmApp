import 'package:app1/Client_Sign_In_Page.dart';
import 'package:app1/authority_sign_in.dart';
import 'package:app1/client_dahboard.dart';
import 'package:app1/client_sign_up_page.dart';
import 'package:app1/lawyer_sign_in.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/logo.png'),
            SizedBox(height: 10),

            Container(
              height:80,
                width: 300,

              child: ElevatedButton(

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClientSignInPage()),
                  );// Navigate to the Client Sign In page
                },
                child:
                    Text('Sign in as Client',style: TextStyle(color: Colors.white,fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(0, 65, 120, 1),
                  )
              ),
            ),
          SizedBox(height: 10),
          Container(
            height: 80,
            width: 300,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LawyerSignInPage())
                  );// Navigate to the Lawyer Sign In page
                },
                child:
                Text('Sign in as Lawyer',style: TextStyle(color: Colors.white,fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(0, 65, 120, 1),
                )
              ),
          ),
            SizedBox(height: 10),
            Container(
              height: 80,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AuthoritySignInPage()),
                  );// Navigate to the Authority Sign In page
                },
                  child:
                  Text('Sign in as Authority',style: TextStyle(color: Colors.white,fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(0, 65, 120, 1),
                  )
              ),
            ),
            SizedBox(height: 20),
            Text('Not a user?', style: TextStyle(fontSize: 20),),
            SizedBox(height: 10),
            Container(
              height: 80,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClientDashboard()),
                  );// Navigate to the Sign Up page
                },
                  child:
                  Text('Sign Up!',style: TextStyle(color: Colors.white,fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(0, 65, 120, 1),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}