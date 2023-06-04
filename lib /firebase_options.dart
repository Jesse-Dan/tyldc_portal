// File d by FlutterFire CLI.
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDSLBAPo2v4pZFs2wV6o8WeXseS8tOGXIU',
    appId: '1:390567584749:web:a1aa9135fef7df72d57de4',
    messagingSenderId: '390567584749',
    projectId: 'tyldc-registry',
    authDomain: 'tyldc-registry.firebaseapp.com',
    databaseURL:
        'https://tyldc-registry-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'tyldc-registry.appspot.com',
    measurementId: 'G-FVRGNG2S19',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAqBMqLWDb9EyHVkD3qXq5XNDnT3fDUjdc',
    appId: '1:390567584749:android:9fcaafd0f84a8e8bd57de4',
    messagingSenderId: '390567584749',
    projectId: 'tyldc-registry',
    databaseURL:
        'https://tyldc-registry-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'tyldc-registry.appspot.com',
  );
}
