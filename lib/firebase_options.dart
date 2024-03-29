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
    apiKey: 'AIzaSyDaHWoMvjC8pd3uENGiTKjkND9YQBRoJ74',
    appId: '1:754096441759:web:f1d9501fafad89939e95aa',
    messagingSenderId: '754096441759',
    projectId: 'tiktok-camel',
    authDomain: 'tiktok-camel.firebaseapp.com',
    storageBucket: 'tiktok-camel.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAxOOzK2vOWncRCgtBhUoHk-T_sqTkKYr4',
    appId: '1:754096441759:android:03764b9a328c0ea39e95aa',
    messagingSenderId: '754096441759',
    projectId: 'tiktok-camel',
    storageBucket: 'tiktok-camel.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBctJdvv7qLm7R37zFQO2Wxfp2mjSJjyC4',
    appId: '1:754096441759:ios:b10c10dd83d93c829e95aa',
    messagingSenderId: '754096441759',
    projectId: 'tiktok-camel',
    storageBucket: 'tiktok-camel.appspot.com',
    androidClientId: '754096441759-6191thdo3ktkdqjnj5jhlpiaillq4spp.apps.googleusercontent.com',
    iosClientId: '754096441759-e8ufoeqiffg5etb385gsmh832gaeuvde.apps.googleusercontent.com',
    iosBundleId: 'com.example.tiktokapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBctJdvv7qLm7R37zFQO2Wxfp2mjSJjyC4',
    appId: '1:754096441759:ios:b10c10dd83d93c829e95aa',
    messagingSenderId: '754096441759',
    projectId: 'tiktok-camel',
    storageBucket: 'tiktok-camel.appspot.com',
    androidClientId: '754096441759-6191thdo3ktkdqjnj5jhlpiaillq4spp.apps.googleusercontent.com',
    iosClientId: '754096441759-e8ufoeqiffg5etb385gsmh832gaeuvde.apps.googleusercontent.com',
    iosBundleId: 'com.example.tiktokapp',
  );
}
