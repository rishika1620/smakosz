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
    apiKey: 'AIzaSyBL6ANlDoJHEoeaOHaghzTx_apmAK3pewE',
    appId: '1:210021228317:web:b3cde34ea9e439645b0bf4',
    messagingSenderId: '210021228317',
    projectId: 'smakosz-ddd3b',
    authDomain: 'smakosz-ddd3b.firebaseapp.com',
    storageBucket: 'smakosz-ddd3b.firebasestorage.app',
    measurementId: 'G-F40PPZHV7Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBPlITFC6hIxCZ42uvXT2kRAqtIwQGoPeA',
    appId: '1:210021228317:android:e3917dfc94c8bf655b0bf4',
    messagingSenderId: '210021228317',
    projectId: 'smakosz-ddd3b',
    storageBucket: 'smakosz-ddd3b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAAKnMlJ7_plNng51rrnzzMg5U7YrTpR9Y',
    appId: '1:210021228317:ios:922ce841d796b4615b0bf4',
    messagingSenderId: '210021228317',
    projectId: 'smakosz-ddd3b',
    storageBucket: 'smakosz-ddd3b.firebasestorage.app',
    iosBundleId: 'com.example.smakosz',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAAKnMlJ7_plNng51rrnzzMg5U7YrTpR9Y',
    appId: '1:210021228317:ios:922ce841d796b4615b0bf4',
    messagingSenderId: '210021228317',
    projectId: 'smakosz-ddd3b',
    storageBucket: 'smakosz-ddd3b.firebasestorage.app',
    iosBundleId: 'com.example.smakosz',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBL6ANlDoJHEoeaOHaghzTx_apmAK3pewE',
    appId: '1:210021228317:web:77a95fa9ecd8e5d35b0bf4',
    messagingSenderId: '210021228317',
    projectId: 'smakosz-ddd3b',
    authDomain: 'smakosz-ddd3b.firebaseapp.com',
    storageBucket: 'smakosz-ddd3b.firebasestorage.app',
    measurementId: 'G-4RECTBXRQB',
  );
}
