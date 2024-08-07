// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCk-wvVmRmoKp5s4zIV688lHmeuEMaKa8M',
    appId: '1:8842716058:web:cd69f2b024525fd8039023',
    messagingSenderId: '8842716058',
    projectId: 'order-of-the-gourmands',
    authDomain: 'order-of-the-gourmands.firebaseapp.com',
    storageBucket: 'order-of-the-gourmands.appspot.com',
    measurementId: 'G-N1J7VHMP9C',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAltp1su_hY1hwDAgnzH1vPOccCqD7XtN0',
    appId: '1:8842716058:ios:a74515bd4feabb0e039023',
    messagingSenderId: '8842716058',
    projectId: 'order-of-the-gourmands',
    storageBucket: 'order-of-the-gourmands.appspot.com',
    iosBundleId: 'com.example.orderOfTheGourmand',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAltp1su_hY1hwDAgnzH1vPOccCqD7XtN0',
    appId: '1:8842716058:ios:a74515bd4feabb0e039023',
    messagingSenderId: '8842716058',
    projectId: 'order-of-the-gourmands',
    storageBucket: 'order-of-the-gourmands.appspot.com',
    iosBundleId: 'com.example.orderOfTheGourmand',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCk-wvVmRmoKp5s4zIV688lHmeuEMaKa8M',
    appId: '1:8842716058:web:655cea8a50a88fce039023',
    messagingSenderId: '8842716058',
    projectId: 'order-of-the-gourmands',
    authDomain: 'order-of-the-gourmands.firebaseapp.com',
    storageBucket: 'order-of-the-gourmands.appspot.com',
    measurementId: 'G-Q0RPHYEPW0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCmQSyC-8Kwt5gkqAKxTcdr3esebMp6a2c',
    appId: '1:8842716058:android:fbffed7bda202daa039023',
    messagingSenderId: '8842716058',
    projectId: 'order-of-the-gourmands',
    storageBucket: 'order-of-the-gourmands.appspot.com',
  );

}