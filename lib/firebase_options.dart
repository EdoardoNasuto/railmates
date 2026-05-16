import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:firebase_core/firebase_core.dart';

@NowaGenerated()
class DefaultFirebaseOptions {
  static FirebaseOptions? get currentPlatform {
    if (NPlatform.isWeb) {
      return web;
    } else if (NPlatform.isAndroid) {
      return android;
    }
    if (NPlatform.isIOS || NPlatform.isMacOs) {
      return ios;
    }
    return null;
  }

  static const FirebaseOptions web = const FirebaseOptions(
    apiKey: 'AIzaSyAZJN9TjFRO0Ve9SKc3kReNUlL2xuaWlgw',
    appId: '1:1002034523365:web:a53f281809447c3f17380c',
    messagingSenderId: '1002034523365',
    projectId: 'railmates',
    authDomain: 'railmates.firebaseapp.com',
    storageBucket: 'railmates.firebasestorage.app',
    measurementId: 'G-SXRL3J2FH9',
  );

  static const FirebaseOptions ios = const FirebaseOptions(
    apiKey: 'AIzaSyBTEhCYyXg-r_N9s0n3X1mI_9gRcOwDwyw',
    appId: '1:1002034523365:ios:9ca1da038bad4a2a17380c',
    messagingSenderId: '1002034523365',
    projectId: 'railmates',
    storageBucket: 'railmates.firebasestorage.app',
    androidClientId: '',
    iosBundleId: 'com.example.railmates',
  );

  static const FirebaseOptions android = const FirebaseOptions(
    apiKey: 'AIzaSyCGTkwQI6Od0Bha9BXUSzpX8jD-ZpEVOOc',
    appId: '1:1002034523365:android:9c330bf0addf651717380c',
    messagingSenderId: '1002034523365',
    projectId: 'railmates',
    storageBucket: 'railmates.firebasestorage.app',
  );
}
