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
    apiKey: 'AIzaSyBT6abJfWyQS3Ef0vnyd7S9iXG948-AdSk',
    appId: '1:1087445092000:web:a6951017d9224069ba2bc5',
    messagingSenderId: '1087445092000',
    projectId: 'snaphere-d5518',
    authDomain: 'snaphere-d5518.firebaseapp.com',
    storageBucket: 'snaphere-d5518.appspot.com',
    measurementId: 'G-1W1CZXPXGG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBcNVYAxEZiI_9IhPT-AuPFfYwSY8Zl7HY',
    appId: '1:1087445092000:android:76e0e72fcb559831ba2bc5',
    messagingSenderId: '1087445092000',
    projectId: 'snaphere-d5518',
    storageBucket: 'snaphere-d5518.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCWyngqEB0GpVwHXOGlnUqyMszzDemu7Og',
    appId: '1:1087445092000:ios:a878da020ebc6fecba2bc5',
    messagingSenderId: '1087445092000',
    projectId: 'snaphere-d5518',
    storageBucket: 'snaphere-d5518.appspot.com',
    iosClientId: '1087445092000-l012t3k354gbml839u470f8jd99bkkvb.apps.googleusercontent.com',
    iosBundleId: 'com.snaphere.snaphere',
  );
}
