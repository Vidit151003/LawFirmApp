import 'package:app1/welcome_page.dart';
import 'package:flutter/material.dart';



class ClientDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height:100,),

                 Container(
                   height: 80,
                    width: 80,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://ik.imagekit.io/upscale/wp-content/uploads/2022/09/cropped-favicon.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Welcome!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: "Kadwa"),
                  ),
                ),

                SizedBox(height: 50,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    InkWell(
                    onTap: () => Navigator.push(
                      context,
                       MaterialPageRoute(builder: (context) => WelcomePage()),
                    ),
                      child: Container(
                        height:165,
                        width: 140,

                        child: Center(child: Image.asset('assets/images/Petition.png'))),
                    ),

                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WelcomePage()),
                      ),
                      child: Container(
                        height:165,
                        width: 135,
                        child: Image.asset('assets/images/Review Petition.png'),
                      ),
                    )
                  ],
                ),

                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WelcomePage()),
                      ),
                      child: Container(
                        height:165,
                        width: 135,
                        child: Image.asset('assets/images/img.png')),
                      ),


                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WelcomePage()),
                      ),
                      child: Container(
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
      );

  }
}