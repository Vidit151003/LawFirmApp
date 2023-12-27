
import 'package:app1/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(const UpScale());
}

class UpScale extends StatelessWidget {
  const UpScale({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UpScaleLegal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(0, 65, 120, 1)),
        useMaterial3: true,
      ),
      home: AnimatedSplashScreen(
        duration: 4500,
        splash: Image.asset('assets/images/logo.png'),
        splashIconSize: double.infinity,
        nextScreen: WelcomePage(),
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}

