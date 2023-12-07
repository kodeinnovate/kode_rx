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
    apiKey: 'AIzaSyANmnKKi2nrQTxEliyA3biIoNeyoNUyi3c',
    appId: '1:229890412339:web:6d1025aa5aaddb5a9cf846',
    messagingSenderId: '229890412339',
    projectId: 'kodeneo-4a446',
    authDomain: 'kodeneo-4a446.firebaseapp.com',
    storageBucket: 'kodeneo-4a446.appspot.com',
    measurementId: 'G-6D9MMVMBNF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAZA-BDfnmq9jwsGd7iRNWAJ1NxpIgtqIw',
    appId: '1:229890412339:android:26d1bdc0379988889cf846',
    messagingSenderId: '229890412339',
    projectId: 'kodeneo-4a446',
    storageBucket: 'kodeneo-4a446.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDC8Q1glRlBb63pNn6qCS_jYFybC_HrySg',
    appId: '1:229890412339:ios:c777b4414995e0f69cf846',
    messagingSenderId: '229890412339',
    projectId: 'kodeneo-4a446',
    storageBucket: 'kodeneo-4a446.appspot.com',
    iosBundleId: 'com.example.kodeRx',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDC8Q1glRlBb63pNn6qCS_jYFybC_HrySg',
    appId: '1:229890412339:ios:0e14a3b9849f1cdf9cf846',
    messagingSenderId: '229890412339',
    projectId: 'kodeneo-4a446',
    storageBucket: 'kodeneo-4a446.appspot.com',
    iosBundleId: 'com.example.kodeRx.RunnerTests',
  );
}