
import 'package:app1/widgets/auth_gate.dart';
import 'package:app1/widgets/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';


import 'package:app1/seed_admin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    // Use debug provider during development. Switch to ReCaptchaV3Provider for web prod.
    // webProvider: ReCaptchaV3Provider('your-recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
  );

  // Temporary script to seed the admin user
  await seedAdmin();

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
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(0, 65, 120, 1)),
        useMaterial3: true,
      ),
      home: AnimatedSplashScreen(
        duration: 1500,
        splash: Image.asset('assets/images/logo.png'),
        splashIconSize: double.infinity,
        nextScreen: Auth_Gate(),
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}


