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
    apiKey: 'AIzaSyD0Hps7tA4Eu06TVIHI1LeX45MfB4GUtyA',
    appId: '1:532101136282:web:640337aa22fd9f8319c423',
    messagingSenderId: '532101136282',
    projectId: 'geetaxi-180c9',
    authDomain: 'geetaxi-180c9.firebaseapp.com',
    databaseURL: 'https://geetaxi-180c9-default-rtdb.firebaseio.com',
    storageBucket: 'geetaxi-180c9.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC09sfm9PBHAqXXFgcDoW83LqmWNonblVU',
    appId: '1:532101136282:android:94944fee1ae621fa19c423',
    messagingSenderId: '532101136282',
    projectId: 'geetaxi-180c9',
    databaseURL: 'https://geetaxi-180c9-default-rtdb.firebaseio.com',
    storageBucket: 'geetaxi-180c9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAgTdworGUHIL9HPfsfdZNpocLQ0t-WyPc',
    appId: '1:532101136282:ios:6810fc5b0775211919c423',
    messagingSenderId: '532101136282',
    projectId: 'geetaxi-180c9',
    databaseURL: 'https://geetaxi-180c9-default-rtdb.firebaseio.com',
    storageBucket: 'geetaxi-180c9.appspot.com',
    iosBundleId: 'com.example.cabRider',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAgTdworGUHIL9HPfsfdZNpocLQ0t-WyPc',
    appId: '1:532101136282:ios:b93f29210e564b3f19c423',
    messagingSenderId: '532101136282',
    projectId: 'geetaxi-180c9',
    databaseURL: 'https://geetaxi-180c9-default-rtdb.firebaseio.com',
    storageBucket: 'geetaxi-180c9.appspot.com',
    iosBundleId: 'com.example.cabRider.RunnerTests',
  );
}
