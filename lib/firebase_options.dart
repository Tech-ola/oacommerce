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
    apiKey: 'AIzaSyCF1MsTLtmiTYotqbtwRlbTc4OjiQTx_qE',
    appId: '1:235783139484:web:bb8c77a8d7d48a7bb53d59',
    messagingSenderId: '235783139484',
    projectId: 'ecommerceapp-a25bd',
    authDomain: 'ecommerceapp-a25bd.firebaseapp.com',
    storageBucket: 'ecommerceapp-a25bd.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCMznHJzq_C-BUIT1JTgM6sjgBa_eV2d7c',
    appId: '1:235783139484:android:7a9370be978be5a5b53d59',
    messagingSenderId: '235783139484',
    projectId: 'ecommerceapp-a25bd',
    storageBucket: 'ecommerceapp-a25bd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD4HaBvoSbjNd3opovG_BQEstz5XbWjyNE',
    appId: '1:235783139484:ios:89d4be999267cc01b53d59',
    messagingSenderId: '235783139484',
    projectId: 'ecommerceapp-a25bd',
    storageBucket: 'ecommerceapp-a25bd.appspot.com',
    androidClientId: '235783139484-p8ggiauon9ov0tenqagmsthgv76i0dqf.apps.googleusercontent.com',
    iosClientId: '235783139484-kc7e5pkpoicc1at0githnpa8rlo3pplq.apps.googleusercontent.com',
    iosBundleId: 'com.example.ecommerce',
  );
}
