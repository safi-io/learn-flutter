
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDRXxkRuQjsG4SZ3gS1zHp3CZtwGCc3EkA',
    appId: '1:724933303592:web:4a77a7bc17a543c85e441d',
    messagingSenderId: '724933303592',
    projectId: 'fir-flutter-cbb0f',
    authDomain: 'fir-flutter-cbb0f.firebaseapp.com',
    storageBucket: 'fir-flutter-cbb0f.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAYkqNFLPTAOgYPcajiihDO0q6ue4WZp1I',
    appId: '1:724933303592:android:02846ecb5ae4e2f15e441d',
    messagingSenderId: '724933303592',
    projectId: 'fir-flutter-cbb0f',
    storageBucket: 'fir-flutter-cbb0f.firebasestorage.app',
  );

}