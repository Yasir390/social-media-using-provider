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
    apiKey: 'AIzaSyBCLEMHKWCuwOHrMpNvkISMsxLxs5z1XcQ',
    appId: '1:395393940527:web:4e32170999d7af2dcddada',
    messagingSenderId: '395393940527',
    projectId: 'social-media-11a58',
    authDomain: 'social-media-11a58.firebaseapp.com',
    storageBucket: 'social-media-11a58.appspot.com',
    measurementId: 'G-35QY6M4KBH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCx7p8WSFlbq5bDh8P_nwqSeGmCB4QGAt0',
    appId: '1:395393940527:android:3792f3e5af224847cddada',
    messagingSenderId: '395393940527',
    projectId: 'social-media-11a58',
    storageBucket: 'social-media-11a58.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAVvFCD528Db-cAiFV5cmO9bo-AF8WE_Kw',
    appId: '1:395393940527:ios:6eb6d9e8211fe9e8cddada',
    messagingSenderId: '395393940527',
    projectId: 'social-media-11a58',
    storageBucket: 'social-media-11a58.appspot.com',
    iosBundleId: 'com.example.socialMedia',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAVvFCD528Db-cAiFV5cmO9bo-AF8WE_Kw',
    appId: '1:395393940527:ios:6eb6d9e8211fe9e8cddada',
    messagingSenderId: '395393940527',
    projectId: 'social-media-11a58',
    storageBucket: 'social-media-11a58.appspot.com',
    iosBundleId: 'com.example.socialMedia',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBCLEMHKWCuwOHrMpNvkISMsxLxs5z1XcQ',
    appId: '1:395393940527:web:3c946afbc354ba2ccddada',
    messagingSenderId: '395393940527',
    projectId: 'social-media-11a58',
    authDomain: 'social-media-11a58.firebaseapp.com',
    storageBucket: 'social-media-11a58.appspot.com',
    measurementId: 'G-VMD5CEDJS0',
  );
}
