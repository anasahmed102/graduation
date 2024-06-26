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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAd4zjx1iIdOOpIVmZuIuLuerCbsXw9OJY',
    appId: '1:750052531746:android:fdeded8ca88ab6945c747b',
    messagingSenderId: '750052531746',
    projectId: 'third-essence-403420',
    databaseURL: 'https://third-essence-403420-default-rtdb.firebaseio.com',
    storageBucket: 'third-essence-403420.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCYJdmZQ8jgNtsoh7adQkU7JxVW9SJDfnY',
    appId: '1:750052531746:ios:59d8840cc35b26735c747b',
    messagingSenderId: '750052531746',
    projectId: 'third-essence-403420',
    databaseURL: 'https://third-essence-403420-default-rtdb.firebaseio.com',
    storageBucket: 'third-essence-403420.appspot.com',
    androidClientId: '750052531746-8tg76umkfupvr2pqjvpbhrrq12habbnr.apps.googleusercontent.com',
    iosClientId: '750052531746-26536qlhstttpktbt0jduf1ip22hmf6o.apps.googleusercontent.com',
    iosBundleId: 'com.example.1prr',
  );
}
