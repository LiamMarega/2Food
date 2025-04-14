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
    apiKey: 'AIzaSyDgck3ysiXW2T3Bby_XrP68FReuZibjyj0',
    appId: '1:212712903666:web:addbfe027201e58f26116b',
    messagingSenderId: '212712903666',
    projectId: 'food-da905',
    authDomain: 'food-da905.firebaseapp.com',
    storageBucket: 'food-da905.firebasestorage.app',
    measurementId: 'G-0M8C555ZGV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCcUO4Dm0MlF2XeDgwZY4Vs-fP12weg4LY',
    appId: '1:212712903666:android:5db91c33ffc220f326116b',
    messagingSenderId: '212712903666',
    projectId: 'food-da905',
    storageBucket: 'food-da905.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDzT0VeIHdPXJuo1DTn1lm5nfsvKyxkkZk',
    appId: '1:212712903666:ios:e630fbd798a8626626116b',
    messagingSenderId: '212712903666',
    projectId: 'food-da905',
    storageBucket: 'food-da905.firebasestorage.app',
    iosBundleId: 'com.example.verygoodcore.snapfood',
  );
}
