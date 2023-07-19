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
    apiKey: 'AIzaSyBSx4scyta7HR-UDJ6IClMUAMS4gn0fDzY',
    appId: '1:772078932776:web:55504c1c1ea02b1c40f61d',
    messagingSenderId: '772078932776',
    projectId: 'fluentfocus-b7c61',
    authDomain: 'fluentfocus-b7c61.firebaseapp.com',
    databaseURL: 'https://fluentfocus-b7c61-default-rtdb.firebaseio.com',
    storageBucket: 'fluentfocus-b7c61.appspot.com',
    measurementId: 'G-XV42X3RE3V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDirI3bLi99kA4sg0Yxmf-khPciJR9fdaM',
    appId: '1:772078932776:android:fb7c5fbb63cb9aed40f61d',
    messagingSenderId: '772078932776',
    projectId: 'fluentfocus-b7c61',
    databaseURL: 'https://fluentfocus-b7c61-default-rtdb.firebaseio.com',
    storageBucket: 'fluentfocus-b7c61.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDp33CosgMG2i2inwYIyvA0Wobrqakr3uw',
    appId: '1:772078932776:ios:d422d3cb1cff003440f61d',
    messagingSenderId: '772078932776',
    projectId: 'fluentfocus-b7c61',
    databaseURL: 'https://fluentfocus-b7c61-default-rtdb.firebaseio.com',
    storageBucket: 'fluentfocus-b7c61.appspot.com',
    iosClientId: '772078932776-jdaq8v2mjnqjo626ajs3vqf1r5g8d7bb.apps.googleusercontent.com',
    iosBundleId: 'com.example.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDp33CosgMG2i2inwYIyvA0Wobrqakr3uw',
    appId: '1:772078932776:ios:5564aacd2fbede1340f61d',
    messagingSenderId: '772078932776',
    projectId: 'fluentfocus-b7c61',
    databaseURL: 'https://fluentfocus-b7c61-default-rtdb.firebaseio.com',
    storageBucket: 'fluentfocus-b7c61.appspot.com',
    iosClientId: '772078932776-aecg6jp768lqpcvhnd5rrbatonvbq1qp.apps.googleusercontent.com',
    iosBundleId: 'com.example.app.RunnerTests',
  );
}
