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
    apiKey: 'AIzaSyCTaCrTuEtv7ZtIAGhHIokmZg0JHZHmejU',
    appId: '1:68224071194:web:18f975a8d94b3f708183a3',
    messagingSenderId: '68224071194',
    projectId: 'fir-6576e',
    authDomain: 'fir-6576e.firebaseapp.com',
    storageBucket: 'fir-6576e.appspot.com',
    measurementId: 'G-S3P6Z6NFYR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBTl4a484kRKeDtSmQz62r3p8JhaYfpKN0',
    appId: '1:68224071194:android:589b53b05015d1f18183a3',
    messagingSenderId: '68224071194',
    projectId: 'fir-6576e',
    storageBucket: 'fir-6576e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD5eGXff8iPs_xweNSRorDSzWUAlSU50C8',
    appId: '1:68224071194:ios:73e7a5afb46fdf0d8183a3',
    messagingSenderId: '68224071194',
    projectId: 'fir-6576e',
    storageBucket: 'fir-6576e.appspot.com',
    iosClientId: '68224071194-52m7gvg2sevk33tjufgh80e2hfn20rcl.apps.googleusercontent.com',
    iosBundleId: 'br.com.marcellamaral.testeFirebaseInstalacaoAutomatica',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD5eGXff8iPs_xweNSRorDSzWUAlSU50C8',
    appId: '1:68224071194:ios:73e7a5afb46fdf0d8183a3',
    messagingSenderId: '68224071194',
    projectId: 'fir-6576e',
    storageBucket: 'fir-6576e.appspot.com',
    iosClientId: '68224071194-52m7gvg2sevk33tjufgh80e2hfn20rcl.apps.googleusercontent.com',
    iosBundleId: 'br.com.marcellamaral.testeFirebaseInstalacaoAutomatica',
  );
}
