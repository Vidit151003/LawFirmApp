import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class AuthoritySignInPage extends StatelessWidget {
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
                    color: Color.fromRGBO(0, 65, 600, 2),
                    spreadRadius: 6,
                    blurRadius: 10,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(56)),                    //borderRadius:16
              ),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Center(
                  child: Column(
                      children: [
                        Text(' ',style: TextStyle(fontSize: 30)),
                        const Text(
                          'Welcome!',
                          style: TextStyle( fontFamily: "Kadwa", fontStyle: FontStyle.italic , fontSize: 24, fontWeight: FontWeight.bold),
                        ),

                        SizedBox(height: 32),
                        TextField(
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(35)),

                            )
                        ),


                        SizedBox(height: 16),

                        TextField(
                          decoration:  InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35))
                            ,
                          ),

                        ),
                        SizedBox(height: 16),
                        Container(
                            height: 50,
                            width: 150,
                            child: ElevatedButton(
                              onPressed: () {
                                // handle button press
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(0, 65, 120, 1),
                              ),
                              child: Text('Submit',style: TextStyle(color: Colors.white,fontSize: 16)),
                            ))]),
                ),

              ),
            ),
          ),
        ),
      ),
    );
  }
}