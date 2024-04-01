
import 'package:app1/widgets/firebase_options.dart';
import 'package:app1/Screens/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await FirebaseAppCheck.instance.activate(
    // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    // argument for `webProvider`
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider: AndroidProvider.playIntegrity,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Device Check provider
    // 3. App Attest provider
    // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider: AppleProvider.appAttest,
  );
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
        duration: 500,
        splash: Image.asset('assets/images/logo.png'),
        splashIconSize: double.infinity,
        nextScreen: const WelcomePage(),
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}
