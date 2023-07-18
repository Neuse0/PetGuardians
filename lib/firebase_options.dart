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
    apiKey: 'AIzaSyBiHv-mJu5VQnJ-lhkHzP41FDYbzkp7nuU',
    appId: '1:274043292034:web:68e4274b00bce183a4679b',
    messagingSenderId: '274043292034',
    projectId: 'petguardian-0000',
    authDomain: 'petguardian-0000.firebaseapp.com',
    storageBucket: 'petguardian-0000.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDOh_TAmwn9dfvA1GC0Zc3lUx0aM5NNMgo',
    appId: '1:274043292034:android:ddf5b90fd28a2ecea4679b',
    messagingSenderId: '274043292034',
    projectId: 'petguardian-0000',
    storageBucket: 'petguardian-0000.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD2REpJmTq87SZz7YpyJhrny7FztSL0ASw',
    appId: '1:274043292034:ios:861530b6026000a9a4679b',
    messagingSenderId: '274043292034',
    projectId: 'petguardian-0000',
    storageBucket: 'petguardian-0000.appspot.com',
    iosClientId: '274043292034-fvsv7i4e0r0irdao4655kj1kebc1c3mi.apps.googleusercontent.com',
    iosBundleId: 'com.example.petguardian',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD2REpJmTq87SZz7YpyJhrny7FztSL0ASw',
    appId: '1:274043292034:ios:cbe67a641c6ec40fa4679b',
    messagingSenderId: '274043292034',
    projectId: 'petguardian-0000',
    storageBucket: 'petguardian-0000.appspot.com',
    iosClientId: '274043292034-fjp5vpk0j0278mgbs0p4pgjag1e7v95v.apps.googleusercontent.com',
    iosBundleId: 'com.example.petguardian.RunnerTests',
  );
}