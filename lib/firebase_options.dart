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
    apiKey: 'AIzaSyDtKPdAaBnMZaQbTHPEhTDoh9I-gfuvG8A',
    appId: '1:162938656196:web:1318dd3b6b1ec2f3980091',
    messagingSenderId: '162938656196',
    projectId: 'order-22222',
    authDomain: 'order-22222.firebaseapp.com',
    storageBucket: 'order-22222.appspot.com',
    measurementId: 'G-JC0Z9M17JF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD2iJAyTA5J1YuU0CkQNrKlCMdJ-43NsR4',
    appId: '1:162938656196:android:885042be65ad58f3980091',
    messagingSenderId: '162938656196',
    projectId: 'order-22222',
    storageBucket: 'order-22222.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD1SBhqnXjhfNsz3-ufk035OabEIXm2YEA',
    appId: '1:162938656196:ios:79ade7fbff1fa43c980091',
    messagingSenderId: '162938656196',
    projectId: 'order-22222',
    storageBucket: 'order-22222.appspot.com',
    iosClientId: '162938656196-r01veapl2tpdtv3nut9tcshbim4qfc0o.apps.googleusercontent.com',
    iosBundleId: 'com.example.orderApp',
  );
}