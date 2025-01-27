// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCoPbBiVF31Kvena2CZswVslwWRXnEkDYE',
    appId: '1:481632927012:web:a23da213064129651147b1',
    messagingSenderId: '481632927012',
    projectId: 'upscalelegal-2608a',
    authDomain: 'upscalelegal-2608a.firebaseapp.com',
    storageBucket: 'upscalelegal-2608a.appspot.com',
    measurementId: 'G-4R5Y2SGNYL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBl9pIIvz3nGkNRsA8gO-0Mw5UNzBCcs1I',
    appId: '1:481632927012:android:179665e62cd916bf1147b1',
    messagingSenderId: '481632927012',
    projectId: 'upscalelegal-2608a',
    storageBucket: 'upscalelegal-2608a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCUnUhmh80ADr3QB8m4zit1vIFHZL8Ei2c',
    appId: '1:481632927012:ios:483593415b6377061147b1',
    messagingSenderId: '481632927012',
    projectId: 'upscalelegal-2608a',
    storageBucket: 'upscalelegal-2608a.appspot.com',
    iosBundleId: 'com.example.app1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCUnUhmh80ADr3QB8m4zit1vIFHZL8Ei2c',
    appId: '1:481632927012:ios:a23803e29b8ab2661147b1',
    messagingSenderId: '481632927012',
    projectId: 'upscalelegal-2608a',
    storageBucket: 'upscalelegal-2608a.appspot.com',
    iosBundleId: 'com.example.app1.RunnerTests',
  );
}
