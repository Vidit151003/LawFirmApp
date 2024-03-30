import 'package:app1/signin/Client_Sign_In_Page.dart';
import 'package:app1/signin/client_sign_up_page.dart';
import 'package:app1/signin/phone_login.dart';
import 'package:app1/widgets/widgets.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key, Key? Key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/logo.png'),
                const SizedBox(height: 25),
                const Text(
                  "Welcome!",
                  style: TextStyle(
                    fontFamily: "Istok Web",
                    fontSize: 32,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                OvalButtonWithIcon(
                    name: "Sign in with email",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ClientSignInPage(),
                        ),
                      );
                    },
                    icon: Icons.email_rounded, color: Colors.white,),

                const SizedBox(
                  height: 10,
                ),
                /*Container(
                  height: 65,
                  width: 280,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LawyerSignInPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign in as Lawyer',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(0, 65, 120, 1),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 65,
                  width: 280,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AuthoritySignInPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign in as Authority',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(0, 65, 120, 1),
                    ),
                  ),
                ),
                SizedBox(height: 16),*/
                OvalButtonWithIcon(
                    name: "Sign in with Phone",
                    onPressed:() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PhoneLogin(),
                        ),
                      );
                      // Handle phone sign-in logic here
                      // You can navigate to a specific phone sign-in page or use a library like firebase_auth
                    },
                  icon: Icons.phone, color: Colors.white),

                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Not a User ? Sign Up!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
