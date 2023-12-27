import 'package:flutter/material.dart';


class LawyerSignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 65, 120, 1),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 400,
              width: 500,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 65, 120, 0.2),
                    spreadRadius: 6,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(56)),
              ),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Center(
                  child: Column(children: [
                    SizedBox(height: 20,),
                    const Text(
                      'Welcome Lawyer!',
                      style: TextStyle(
                          fontFamily: "Kadwa",
                          fontStyle: FontStyle.italic,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 32),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Color.fromRGBO(0, 65, 120, 1),
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            if (emailController.text.isEmpty &&
                                passwordController.text.isEmpty) {
                              // If any field is empty, show a snackbar with an error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Please enter your email and password.'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else if (emailController.text.isEmpty)
                            {
                              // If any field is empty, show a snackbar with an error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Please enter your email '),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }  else if (passwordController.text.isEmpty) {
                              // If any field is empty, show a snackbar with an error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Please enter your password.'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }else {
                              // If both fields are filled, you can proceed with your logic
                              // For example, you can call a function to handle the sign-in process
                              handleSignIn(emailController.text,
                                  passwordController.text, context);
                            }
                          },
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void handleSignIn(String email, String password, BuildContext context) {
    // Add your sign-in logic here
    print('Email: $email, Password: $password');
    // You can navigate to another screen or perform other actions based on the sign-in information
  }
}
